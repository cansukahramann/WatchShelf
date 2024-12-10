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
    private var model: TVShowDetailModel!
    private var tvCastModel = [SeriesCast]()
    private var tvVideoModel = [Results]()
    private var tvSimilarModel = [SimilarResult]()
    private var tvShowID: Int
    
    init(tvShowID: Int) {
        self.tvShowID = tvShowID
    }
    
    func loadTVDetail(completion: @escaping(Result<(TVShowDetailModel,[SeriesCast],[Results], [SimilarResult] ),Error>) -> Void) {
        
        loadTVDetail()
        loadTVVideo()
        loadTVCredits()

        group.notify(queue: .main) { [weak self] in
            guard let self else { return }
            if let tvShowdetail = model {
                completion(.success((model, tvCastModel, tvVideoModel, tvSimilarModel)))
            } else {
                let error = NSError(domain: "TVShowDetailService", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to load tv show detail"])
                completion(.failure(error))
            }
        }
    }
    
    private func loadTVDetail() {
        group.enter()
        NetworkManager.shared.request(DetailAPI.tvShowDetail(tvShowID:tvShowID)) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let response):
                model = mapDetailResponse(from: response.data)!
            case .failure(let error):
                print(error)
            }
            group.leave()
        }
    }
    
    private func loadTVVideo() {
        group.enter()
        NetworkManager.shared.request(DetailAPI.tvShowVideo(tvShowID: tvShowID)) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let response):
                tvVideoModel = mapVideoResponse(from: response.data)!
            case .failure(let error):
                print(error)
            }
            group.leave()
        }
    }
    
    private func loadTVCredits() {
        group.enter()
        NetworkManager.shared.request(DetailAPI.tvShowCredits(tvShowID: tvShowID)) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let response):
                tvCastModel = mapCreditsResponse(from: response.data)!
            case .failure(let error):
                print(error)
            }
            group.leave()
        }
    }
    
    private func mapDetailResponse(from data: Data) -> TVShowDetailModel? {
        let response = try! JSONDecoder().decode(TVShowDetailModel.self, from: data)
        return response
    }
    
    private func mapVideoResponse(from data: Data) -> [Results]? {
        let response  = try! JSONDecoder().decode(MovieVideoModel.self, from: data)
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
