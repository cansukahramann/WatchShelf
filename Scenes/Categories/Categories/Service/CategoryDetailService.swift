//
//  CategoryDetailService.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 20.11.2024.
//

import Foundation
import Moya

final class CategoryDetailService {
    private var genreID: Int
    
    init(genreID: Int) {
        self.genreID = genreID
    }
    
    func loadCategoryDetail(contentType: ContentType,requestModel: CommonRequestModel, completion: @escaping(Result<([DiscoverResult]),Error>) -> Void) {
        switch contentType {
        case .movie:
            loadMovieGenre(requestModel: requestModel,completion: completion)
        case .tvShow:
            loadTVGenre(requestModel: requestModel,completion: completion)
        }
    }
    
    private func loadMovieGenre(requestModel: CommonRequestModel, completion: @escaping(Result<([DiscoverResult]),Error>) -> Void) {
        NetworkManager.shared.request(DiscoverAPI.movie(genres: [genreID],requestModel: requestModel)) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let response):
                let movies = mapDetailResponse(from: response.data)
                completion(.success(movies))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func loadTVGenre(requestModel: CommonRequestModel, completion: @escaping(Result<([DiscoverResult]),Error>) -> Void) {
        NetworkManager.shared.request(DiscoverAPI.tv(genres: [genreID], requestModel: requestModel)) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let response):
                let tvShows = mapDetailResponse(from: response.data)
                completion(.success(tvShows))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func mapDetailResponse(from data: Data) -> [DiscoverResult] {
        let response = try! JSONDecoder().decode(DiscoverModel.self, from: data)
        return response.results
    }
}
