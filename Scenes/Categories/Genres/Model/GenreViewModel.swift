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
    var genreModel = [GenreResponse]()
    private let service: GenreService!
    
    init(service: GenreService) {
        self.service = service
    }

    func fetchGenre() {
        service.loadGenre { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let (genreModel)):
                self.genreModel = genreModel
                self.delegate?.updateCollectionView()
            case .failure(let error):
                print(error)
            }
        }
    }
}
