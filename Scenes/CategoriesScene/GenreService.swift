//
//  GenreService.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 21.11.2024.
//

import Foundation
import Moya

final class GenreService {
    private let provider = MoyaProvider<GenreAPI>()
    private var group = DispatchGroup()
    
    func loadGenre(completion: @escaping(Result<([GenreResponse]),Error>) -> Void) {
        var genreModel = [GenreResponse]()
        group.enter()
        provider.request(.movie) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let response):
                let movieGenres = mapGenreResponse(from: response.data)
                genreModel.append(contentsOf: movieGenres)
            case .failure(let error):
                print(error)
            }
            group.leave()
        }
        
        group.enter()
        provider.request(.tv) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let response):
                let tvGenres = mapGenreResponse(from: response.data)
                genreModel.append(contentsOf: tvGenres)
            case .failure(let error):
                print(error)
            }
            group.leave()
        }
        
        group.notify(queue: .main) {
            completion(.success(genreModel))
        }
    }
    
    private func mapGenreResponse(from data: Data) -> [GenreResponse]  {
        let response = try! JSONDecoder().decode(GenreModel.self, from: data)
        return response.genres
    }
}
