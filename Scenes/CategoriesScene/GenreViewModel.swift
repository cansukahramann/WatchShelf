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
    private let genreProvider = MoyaProvider<GenreAPI>()
    var genreModel = [GenreResponse]()
    
    func fetchDetail() {
        genreProvider.request(.movie) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let response):
                genreModel = mapGenreResponse(from: response.data)
                print(genreModel)
                delegate?.updateCollectionView()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func mapGenreResponse(from data: Data) -> [GenreResponse]  {
        let response = try! JSONDecoder().decode(GenreModel.self, from: data)
        return response.genres
    }
}
