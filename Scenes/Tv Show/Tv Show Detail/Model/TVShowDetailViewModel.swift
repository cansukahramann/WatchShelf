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
    
    var model: TVShowDetailModel!
    var tvCastModel = [SeriesCast]()
    var tvVideoModel = [Results]()
    var tvSimilarModel = [SimilarResult]()
    weak var delegate: TVShowDetailViewModelDelegate!
    private let service: TVShowDetailService!
    var tvShowID: Int
    
    init(service: TVShowDetailService, tvShowID: Int) {
        self.service = service
        self.tvShowID = tvShowID
    }
    
    var isFavorite: Bool {
        WatchListStore.shared.isMediaSaved(id: model.id)
    }
    
    var favoriteStatusChangeMessage: String {
        isFavorite ? "Added to Watchlist" : "Removed from Watchlist"
    }
    
    func fetchTVShowDetail() {
        service.loadTVDetail() { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let (model, tvCastModel, tvVideoModel, tvSimilarModel)):
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


