//
//  MovieDetailViewModel.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 8.10.2024.
//

import Foundation
import Moya

protocol MovieDetailViewModelDelegate: AnyObject {
    func didFetchDetail()
}

final class MovieDetailViewModel {
    private(set) var detailModel: MovieDetailModel!
    private(set) var casts = [Cast]()
    private(set) var movieVideoModel = [VideoItem]()
    var movieID: Int
    private let service: MovieDetailService!
    weak var delegate: MovieDetailViewModelDelegate?
    
    init(service: MovieDetailService, movieID: Int) {
        self.service = service
        self.movieID = movieID
    }
    
    var isFavorite: Bool {
        WatchListStore.shared.isMediaSaved(id: detailModel.id)
    }
    
    var favoriteStatusChangeMessage: String {
        isFavorite ? "Added to your watch list" : "Removed from your watch list"
    }
    
    func fetchMovieDetail() {
        service.loadMovieDetail() { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let (detailModel, movieCastModel, movieVideoModel)):
                self.detailModel = detailModel
                self.casts = movieCastModel.map()
                self.movieVideoModel = movieVideoModel
                self.delegate?.didFetchDetail()
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension Array where Element == CastMember {
    func map() -> [Cast] {
        self.map {
            Cast(id: $0.id, realName: $0.name, characterName: $0.character, imagePath: $0.profilePath)
        }
    }
}
