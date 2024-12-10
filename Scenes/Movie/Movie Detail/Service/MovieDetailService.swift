//
//  MovieDetailService.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 20.11.2024.
//

import Foundation
import Moya

final class MovieDetailService {
    private let group = DispatchGroup()
    private var detailModel: MovieDetailModel!
    private var similarModel = [SimilarResult]()
    private var movieCastModel = [Cast]()
    private var movieVideoModel = [Results]()
    private var movieID: Int
    
    init(movieID: Int) {
        self.movieID = movieID
    }
    
    
    func loadMovieDetail(completion: @escaping(Result<(MovieDetailModel,[Cast],[Results]),Error>) -> Void) {
        
        loadMovieDetail()
        loadMovieCredits()
        loadMovieVideo()
        
        group.notify(queue: .main) { [weak self] in
            guard let self else { return }
            if let movieDetailModel = detailModel {
                completion(.success((detailModel,movieCastModel,movieVideoModel)))
            } else {
                let error = NSError(domain: "MovieDetailService", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to load movie service"])
                completion(.failure(error))
            }
        }
    }
    
    private func loadMovieDetail() {
        group.enter()
        NetworkManager.shared.request(DetailAPI.movieDetail(movieID: movieID)) { [weak self] result in
            guard let self else { return }
            
            switch result {
            case.success(let response):
                detailModel = mapResponse(from: response.data)
            case.failure(let error):
                print(error)
            }
            group.leave()
        }
    }
    
    private func loadMovieCredits() {
        group.enter()
        NetworkManager.shared.request(DetailAPI.movieCredits(movieID: movieID)) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let response):
                movieCastModel = mapResponseMovieCast(from: response.data)!
            case.failure(let error):
                print(error)
            }
            group.leave()
        }
    }
    
    private func loadMovieVideo() {
        group.enter()
        NetworkManager.shared.request(DetailAPI.movieVideo(movieID: movieID)) { [weak self] result in
            guard let self else { return }
            switch result {
            case.success(let response):
                movieVideoModel = mapResponseMovieTrailer(from: response.data)!
            case.failure(let error):
                print(error)
            }
            group.leave()
        }
    }
    
    private func mapResponse(from data: Data) -> MovieDetailModel? {
        let response = try! JSONDecoder().decode(MovieDetailModel.self, from: data)
        return response
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
