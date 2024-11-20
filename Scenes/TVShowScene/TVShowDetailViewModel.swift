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
    var model: TVShowDetailModel!
    var tvCastModel = [SeriesCast]()
    var tvVideoModel = [Results]()
    var tvSimilarModel = [SimilarResult]()
    let group = DispatchGroup()
    weak var delegate: TVShowDetailViewModelDelegate!
    private let service: TVShowDetailService!
    var seriesID: Int
    
    init(service: TVShowDetailService,seriesID: Int) {
        self.service = service
        self.seriesID = seriesID
    }
    
    
    var isFavorite: Bool {
        WatchListStore.shared.isMediaSaved(id: model.id)
    }
    
    var favoriteStatusChangeMessage: String {
        isFavorite ? "Added to Watchlist" : "Removed from Watchlist"
    }
    
    func fetchTVShowDetail() {
        service.loadTVDetail(seriesID:seriesID) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let (model,tvCastModel,tvVideoModel, tvSimilarModel)):
                self.model = model
                self.tvCastModel = tvCastModel
                self.tvVideoModel = tvVideoModel
                self.tvSimilarModel = tvSimilarModel
                self.delegate.didFetchDetail()
            case .failure(let error):
                print(error)
            }
        }
    }
  
}


