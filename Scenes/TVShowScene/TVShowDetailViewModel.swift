//
//  TVShowDetailViewModel.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 26.10.2024.
//

import Foundation
import Moya 

protocol TVShowDetailViewModelDelegate: AnyObject {
    func didFetchDetail()
}

class TVShowDetailViewModel {
    
    private let tvDetailProvider = MoyaProvider<DetailAPI>() 
    var seriesID: Int
    var model: SeriesDetailModel!
    var tvCastModel = [SeriesCast]()
    var tvVideoModel = [Results]()
    var tvSimilarModel = [SimilarResult]()
    let group = DispatchGroup()
    weak var delegate: TVShowDetailViewModelDelegate!
    
    init(tvShowID: Int) {
        self.seriesID = tvShowID
    }
    
    func fetchTVDetail() {
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
        group.enter()
        tvDetailProvider.request(.tvShowSimilar(seriesID: seriesID)) { [weak self] result in
            guard let self else { return }
            switch result {
            case.success(let response):
                tvSimilarModel = mapSimilarResponse(from: response.data)!
            case .failure(let error):
                print(error)
            }
            group.leave()
        }
        
        group.notify(queue: .main) {
            self.delegate.didFetchDetail()
        }
    }
    
    private func mapDetailResponse(from data: Data) -> SeriesDetailModel? {
        let response = try! JSONDecoder().decode(SeriesDetailModel.self, from: data)
        return response
    }
    
    private func mapVideoResponse(from data: Data) -> [Results]? {
        let response  = try! JSONDecoder().decode(MovieVideoModel.self, from: data)
        return response.results
    }
    
    private func mapCreditsResponse(from data: Data) -> [SeriesCast]? {
        let response = try! JSONDecoder().decode(SeriesCastModel.self, from: data)
        return response.cast
    }
    
    private func mapSimilarResponse(from data: Data) -> [SimilarResult]? {
        let response = try! JSONDecoder().decode(SimilarModel.self, from: data)
        return response.results
    }
}


