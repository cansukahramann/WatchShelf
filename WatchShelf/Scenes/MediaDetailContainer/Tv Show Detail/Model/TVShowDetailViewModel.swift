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
    
    private(set) var model: TVShowDetails!
    private(set) var casts = [Cast]()
    private(set) var tvVideoModel = [VideoItem]()
    private(set) var tvSimilarModel = [SimilarResult]()
    var tvShowID: Int
    weak var delegate: TVShowDetailViewModelDelegate!
    private let service: TVShowDetailService!
    
    init(service: TVShowDetailService, tvShowID: Int) {
        self.service = service
        self.tvShowID = tvShowID
    }
    
    var isFavorite: Bool {
        WatchListStore.shared.isMediaSaved(id: model.id)
    }
    
    var favoriteStatusChangeMessage: String {
        isFavorite ? "Added to your watch list" : "Removed from your watch list"
    }
    
    func fetchTVShowDetail() {
        service.loadTVDetail() { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let (model, tvCastModel, tvVideoModel, tvSimilarModel)):
                self.model = model
                self.casts = tvCastModel.map()
                self.tvVideoModel = tvVideoModel
                self.tvSimilarModel = tvSimilarModel
                self.delegate.didFetchDetail()
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension Array where Element == SeriesCast {
    func map() -> [Cast] {
        self.map {
            Cast(id: $0.id, realName: $0.name, characterName: $0.character, imagePath: $0.profilePath)
        }
    }
}
