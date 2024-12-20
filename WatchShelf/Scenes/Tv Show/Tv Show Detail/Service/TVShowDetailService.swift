//
//  TVShowDetailService.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 15.11.2024.
//
//
import Foundation
import Moya

final class TVShowDetailService {
    private let group = DispatchGroup()
    private var tvShowDetail: TVShowDetailModel!
    private var tvCastModel = [SeriesCast]()
    private var tvVideoModel = [VideoItem]()
    private var similarTVShows = [SimilarResult]()
    private var tvShowID: Int
    
    init(tvShowID: Int) {
        self.tvShowID = tvShowID
    }
    
    func loadTVDetail(completion: @escaping(Result<(TVShowDetailModel, [SeriesCast], [VideoItem], [SimilarResult]), Error>) -> Void) {
        
        loadTVDetail()
        loadTVVideo()
        loadTVCredits()

        group.notify(queue: .main) { [weak self] in
            guard let self else { return }
            if tvShowDetail != nil {
                completion(.success((tvShowDetail, tvCastModel, tvVideoModel, similarTVShows)))
            } else {
                let error = NSError(domain: "TVShowDetailService", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to load tv show detail"])
                completion(.failure(error))
            }
        }
    }
    
    private func loadTVDetail() {
        group.enter()
        NetworkManager.shared.request(DetailAPI.tvShowDetail(tvShowID:tvShowID)) { [weak self] result in
            guard let self = self else { return }
            let mappingResult: Result<TVShowDetailModel, PresentableError> = ResponseMapper.map(result)
            if let mappingTvShowDetail = try? mappingResult.get() {
                self.tvShowDetail = mappingTvShowDetail
            }
            group.leave()
        }
    }
    
    private func loadTVVideo() {
        group.enter()
        NetworkManager.shared.request(DetailAPI.tvShowVideo(tvShowID: tvShowID)) { [weak self] result in
            guard let self else { return }
            let mappingResult: Result<VideoResponseModel, PresentableError> = ResponseMapper.map(result)
            if let mappingTvVideo = try? mappingResult.get() {
                tvVideoModel = mappingTvVideo.results
            }
            group.leave()
        }
    }
    
    private func loadTVCredits() {
        group.enter()
        NetworkManager.shared.request(DetailAPI.tvShowCredits(tvShowID: tvShowID)) { [weak self] result in
            guard let self else { return }
            let mappingResult: Result<TVShowCastModel, PresentableError> = ResponseMapper.map(result)
            if let mappingTvCredits = try? mappingResult.get() {
                tvCastModel = mappingTvCredits.cast
            }
            group.leave()
        }
    }
    
    private func mapDetailResponse(from data: Data) -> TVShowDetailModel? {
        let response = try! JSONDecoder().decode(TVShowDetailModel.self, from: data)
        return response
    }
    
    private func mapVideoResponse(from data: Data) -> [VideoItem]? {
        let response  = try! JSONDecoder().decode(VideoResponseModel.self, from: data)
        return response.results
    }
    
    private func mapCreditsResponse(from data: Data) -> [SeriesCast]? {
        let response = try! JSONDecoder().decode(TVShowCastModel.self, from: data)
        return response.cast
    }
    
    private func mapSimilarResponse(from data: Data) -> [SimilarResult]? {
        let response = try! JSONDecoder().decode(SimilarModel.self, from: data)
        return response.results
    }
}
