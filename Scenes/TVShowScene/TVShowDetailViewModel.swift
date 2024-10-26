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
                model = mapDetailResponse(from: response.data)
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
}
