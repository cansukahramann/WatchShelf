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
    var detailModel: MovieDetailModel!
    var movieCastModel = [Cast]()
    var movieVideoModel = [Results]()
    var movieID: Int
    private let service: MovieDetailService!
    weak var delegate: MovieDetailViewModelDelegate?
    
    init(service: MovieDetailService ,movieID: Int) {
        self.service = service
        self.movieID = movieID
    }
    
    var isFavorite: Bool {
        WatchListStore.shared.isMediaSaved(id: detailModel.id)
    }
    
    var favoriteStatusChangeMessage: String {
        isFavorite ? "Added to Watchlist" : "Removed from Watchlist"
    }
    
    func fetchMovieDetail() {
        service.loadMovieDetail() { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let (detailModel, movieCastModel, movieVideoModel)):
                self.detailModel = detailModel
                self.movieCastModel = movieCastModel
                self.movieVideoModel = movieVideoModel
                self.delegate?.didFetchDetail()
            case .failure(let error):
                print(error)
            }
        }
    }
}
