//
//  SimilarTVShowViewModel.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 2.12.2024.
//

import Foundation

final class SimilarTVShowViewModel: BaseSimilarViewViewModel {
    override func fetchSimilarContent() {
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
