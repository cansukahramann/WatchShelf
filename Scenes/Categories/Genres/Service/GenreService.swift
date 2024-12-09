//
//  GenreService.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 21.11.2024.
//

import Foundation
import Moya

final class GenreService {
    private var group = DispatchGroup()
    var genreModel = [GenreResponse]()
    
    
    func loadGenre(completion: @escaping(Result<([GenreResponse]),Error>) -> Void) {
        loadGenreMovie()
        loadGenreTV()
        
        group.notify(queue: .main) { [weak self] in
            guard let self else { return }
            completion(.success(genreModel))
        }
    }
    
    private func loadGenreMovie() {
        group.enter()
        NetworkManager.shared.request(GenreAPI.movie) { [weak self] result in
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
    }
    
    private func loadGenreTV() {
        group.enter()
        NetworkManager.shared.request(GenreAPI.tv) { [weak self] result in
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
    }
    
    private func mapGenreResponse(from data: Data) -> [GenreResponse]  {
        let response = try! JSONDecoder().decode(GenreModel.self, from: data)
        return response.genres
    }
}
