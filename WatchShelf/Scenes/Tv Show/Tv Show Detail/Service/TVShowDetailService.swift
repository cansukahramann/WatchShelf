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
    private var tvShowDetail: TVShowDetails!
    private var tvCastModel = [SeriesCast]()
    private var tvVideoModel = [VideoItem]()
    private var similarTVShows = [SimilarResult]()
    private var tvShowID: Int
    
    init(tvShowID: Int) {
        self.tvShowID = tvShowID
    }
    
    func loadTVDetail(completion: @escaping(Result<(TVShowDetails, [SeriesCast], [VideoItem], [SimilarResult]), Error>) -> Void) {
        
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
            let mappingResult: Result<TVShowDetails, PresentableError> = ResponseMapper.map(result)
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
            let mappingResult: Result<VideoResponse, PresentableError> = ResponseMapper.map(result)
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
            let mappingResult: Result<TVShowCastResponse, PresentableError> = ResponseMapper.map(result)
            if let mappingTvCredits = try? mappingResult.get() {
                tvCastModel = mappingTvCredits.cast
            }
            group.leave()
        }
    }
}
