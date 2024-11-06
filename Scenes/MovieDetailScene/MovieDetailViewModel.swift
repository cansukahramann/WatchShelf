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
    
    private let detailProvider = MoyaProvider<DetailAPI>()
    var movieID: Int
    var detailModel: DetailModel!
    var similarModel = [SimilarResult]()
    var movieCastModel = [Cast]()
    var movieVideoModel = [Results]()
    let group = DispatchGroup()
    
    weak var delegate: MovieDetailViewModelDelegate?
    
    init(movieID: Int) {
        self.movieID = movieID
    }
    
    var isFavorite: Bool {
        WatchListStore.shared.isMediaSaved(id: detailModel.id)
    }
    
    var favoriteStatusChangeMessage: String {
        isFavorite ? "Added to Watchlist" : "Removed from Watchlist"
    }
    
    func fetchDetail() {
        group.enter()
        detailProvider.request(.movieDetail(movieID: movieID)) { [weak self] result in
            guard let self else { return }
            
            switch result {
            case.success(let response):
                detailModel = mapResponse(from: response.data)
            case.failure(let error):
                print(error)
            }
            group.leave()
        }
        group.enter()
        detailProvider.request(.movieSimilar(movieID: movieID)) { [weak self] result in
            guard let self else { return }
            switch result {
            case.success(let response):
                similarModel = mapResponseDetail(from: response.data)!
            case.failure(let error):
                print(error)
            }
            group.leave()
        }
        
        
        group.enter()
        detailProvider.request(.movieCredits(movieID: movieID)) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let response):
                movieCastModel = mapResponseMovieCast(from: response.data)!
            case.failure(let error):
                print(error)
            }
            group.leave()
        }
        
        group.enter()
        detailProvider.request(.movieVideo(movieID: movieID)) { [weak self] result in
            guard let self else { return }
            switch result {
            case.success(let response):
                movieVideoModel = mapResponseMovieTrailer(from: response.data)!
            case.failure(let error):
                print(error)
            }
            group.leave()
        }
        
        group.notify(queue: .main) {
            self.delegate?.didFetchDetail()
        }
    }
 
    private func mapResponse(from data: Data) -> DetailModel? {
        let response = try! JSONDecoder().decode(DetailModel.self, from: data)
        return response
    }
    
    private func mapResponseDetail(from data: Data) -> [SimilarResult]? {
        let response = try! JSONDecoder().decode(SimilarModel.self, from: data)
        return response.results
    }
    
    private func mapResponseMovieCast(from data: Data) -> [Cast]? {
        let response = try! JSONDecoder().decode(MovieCastModel.self, from: data)
        return response.cast
    }
    
    private func mapResponseMovieTrailer(from data: Data) -> [Results]? {
        let response = try! JSONDecoder().decode(MovieVideoModel.self, from: data)
        return response.results
    }
}
