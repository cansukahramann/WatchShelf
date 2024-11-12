//
//  GenreViewModel.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 8.11.2024.
//

import Foundation
import Moya

protocol GenreViewModelDelegate: AnyObject {
    func updateCollectionView()
}

final class GenreViewModel {

    weak var delegate: GenreViewModelDelegate?
    private let provider = MoyaProvider<GenreAPI>()
    var genreModel = [GenreResponse]()
    private var group = DispatchGroup()
    
    func fetchDetail() {
        group.enter()
        provider.request(.movie) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let response):
                let movieGenres = mapGenreResponse(from: response.data)
                self.genreModel.append(contentsOf: movieGenres)
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
                self.genreModel.append(contentsOf: tvGenres)
            case .failure(let error):
                print(error)
            }
            group.leave()
        }
        
        group.notify(queue: .main) {
            self.delegate?.updateCollectionView()
        }
    }
    
    private func mapGenreResponse(from data: Data) -> [GenreResponse]  {
        let response = try! JSONDecoder().decode(GenreModel.self, from: data)
        return response.genres
    }
}
