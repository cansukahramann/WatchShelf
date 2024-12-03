//
//  SimilarTVShowViewModel.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 2.12.2024.
//

import Foundation

protocol SimilarTVShowViewModelDelegate: AnyObject {
    func updateCollectionView()
}

final class SimilarTVShowViewModel {
    
    private let service: SimilarServiceProtocol
    private var page = 1
    private var tvShowID: Int
    var similarModel: [SimilarResult] = []
    weak var delegate: SimilarTVShowViewModelDelegate?
    
    init(service: SimilarServiceProtocol, tvShowID: Int) {
        self.service = service
        self.tvShowID = tvShowID
    }
    
    func fetchTVShowSimilarModel() {
        service.similarContentSelected(contentID: tvShowID, requestModel: CommonRequestModel(page: page)) { [weak self] result in
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
