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
    private var movieDetail: MovieDetailModel!
    private var similarResults = [SimilarResult]()
    private var movieCast = [Cast]()
    private var movieVideo = [VideoItem]()
    private var movieID: Int
    
    init(movieID: Int) {
        self.movieID = movieID
    }
    
    func loadMovieDetail(completion: @escaping(Result<(MovieDetailModel, [Cast], [VideoItem]), Error>) -> Void) {
        loadMovieDetail()
        loadMovieCredits()
        loadMovieVideo()
        
        group.notify(queue: .main) { [weak self] in
            guard let self else { return }
            if movieDetail != nil {
                completion(.success((movieDetail, movieCast, movieVideo)))
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
            let mappingResult: Result<MovieDetailModel, PresentableError> = ResponseMapper.map(result)
            if let mappingMovieDetail = try? mappingResult.get() {
                movieDetail = mappingMovieDetail
            }
            group.leave()
        }
    }
    
    private func loadMovieCredits() {
        group.enter()
        NetworkManager.shared.request(DetailAPI.movieCredits(movieID: movieID)) { [weak self] result in
            guard let self else { return }
            let mappingResult: Result<MovieCastModel, PresentableError> = ResponseMapper.map(result)
            if let mappedMovieCast = try? mappingResult.get() {
                movieCast = mappedMovieCast.cast
            }
            group.leave()
        }
    }
    
    private func loadMovieVideo() {
        group.enter()
        NetworkManager.shared.request(DetailAPI.movieVideo(movieID: movieID)) { [weak self] result in
            guard let self else { return }
            let mappingResult: Result<VideoResponseModel, PresentableError> = ResponseMapper.map(result)
            if let mappedMovieVideo = try? mappingResult.get() {
                movieVideo = mappedMovieVideo.results
            }
            group.leave()
        }
    }
}
