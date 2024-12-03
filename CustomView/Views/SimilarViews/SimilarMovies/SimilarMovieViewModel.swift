//
//  SimilarMovieViewModel.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 30.11.2024.
//

import Foundation

protocol SimilarMovieViewModelDelegate: AnyObject {
    func updateCollectionView()
}

final class SimilarMovieViewModel {
    private let service: SimilarServiceProtocol!
    private var movieID: Int
    private var page = 1
    var similarModel: [SimilarResult] = []
    weak var delegate: SimilarMovieViewModelDelegate?
    var shouldRequestNextPage = true
    var isFetchingContent = false
    
    init(service: SimilarServiceProtocol ,movieID: Int) {
        self.service = service
        self.movieID = movieID
    }
    
    func fetchSimilarModel() {
        service.similarContentSelected(contentID: movieID, requestModel: CommonRequestModel(page: page)) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let result):
                self.similarModel.append(contentsOf: result)
                self.page += 1
            case .failure(let error):
                print(error)
            }
            delegate?.updateCollectionView()
        }
    }
}
