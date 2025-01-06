//
//  SimilarContentViewModel.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 5.01.2025.
//

import Foundation

protocol SimilarContentViewModelDelegate: AnyObject {
    func updateCollectionView()
}

class SimilarContentViewModel {
    let service: SimilarServiceProtocol!
    let similarID: Int
    var page = 1
    var similarModel: [SimilarResult] = []
    var shouldRequestNextPage = true
    var isFetchingContent = false
    
    weak var delegate: SimilarContentViewModelDelegate?
    
    init(service: SimilarServiceProtocol ,similarID: Int) {
        self.service = service
        self.similarID = similarID
    }
    
    func fetchSimilarContent() {
        service.similarContentSelected(similarID: similarID, requestModel: CommonRequestModel(page: page)) { [weak self] result in
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
