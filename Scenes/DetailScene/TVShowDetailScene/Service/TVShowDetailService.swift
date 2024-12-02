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
    private let tvDetailProvider = MoyaProvider<DetailAPI>()
    private let group = DispatchGroup()
    
    func loadTVDetail(seriesID: Int, completion: @escaping(Result<(TVShowDetailModel,[SeriesCast],[Results], [SimilarResult] ),Error>) -> Void) {
        var model: TVShowDetailModel!
        var tvCastModel = [SeriesCast]()
        var tvVideoModel = [Results]()
        var tvSimilarModel = [SimilarResult]()
        group.enter()
        tvDetailProvider.request(.tvShowDetail(seriesID:seriesID)) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let response):
                model = mapDetailResponse(from: response.data)!
            case .failure(let error):
                print(error)
            }
            group.leave()
        }
        group.enter()
        tvDetailProvider.request(.tvShowVideo(seriesID: seriesID)) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let response):
                tvVideoModel = mapVideoResponse(from: response.data)!
            case .failure(let error):
                print(error)
            }
            group.leave()
        }
        group.enter()
        tvDetailProvider.request(.tvShowCredits(seriesID: seriesID)) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let response):
                tvCastModel = mapCreditsResponse(from: response.data)!
            case .failure(let error):
                print(error)
            }
            group.leave()
        }
//        group.enter()
//        tvDetailProvider.request(.tvShowSimilar(seriesID: seriesID)) { [weak self] result in
//            guard let self else { return }
//            switch result {
//            case.success(let response):
//                tvSimilarModel = mapSimilarResponse(from: response.data)!
//            case .failure(let error):
//                print(error)
//            }
//            group.leave()
//        }
        
        group.notify(queue: .main) {
            if let tvShowdetail = model {
                completion(.success((model, tvCastModel, tvVideoModel, tvSimilarModel)))
            } else {
                let error = NSError(domain: "TVShowDetailService", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to load tv show detail"])
                completion(.failure(error))
            }
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
