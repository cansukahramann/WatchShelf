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
    private var genreModel = [GenreResponse]()
    
    func loadGenre(completion: @escaping(Result<([GenreResponse]), PresentableError>) -> Void) {
        loadGenre(api: .movie)
        loadGenre(api: .tv)
        group.notify(queue: .main) { [weak self] in
            guard let self else { return }
            completion(.success(genreModel))
        }
    }
    
    private func loadGenre(api: GenreAPI) {
        group.enter()
        NetworkManager.shared.request(api) { [weak self] result in
            guard let self else { return }
            let mappingResult: Result<GenreModel, PresentableError> = ResponseMapper.map(result)
            if let model = try? mappingResult.get() {
                genreModel.append(contentsOf: model.genres)
            }
            group.leave()
        }
    }
}

