//
//  ContentViewModel.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 23.09.2024.
//

import Foundation
import Moya

protocol ContentViewModelDelegate: AnyObject {
    func updateCollectionView()
}

final class ContentViewModel {
    weak var delegate: ContentViewModelDelegate?
    private let service: ContentServiceProtocol
    
    var allContentResults = [ContentResult]()
    private var page = 1
    private var shouldRequestNextPage = true
    private var isFetchingContent = false
    
    init(service: ContentServiceProtocol) {
        self.service = service
    }
    
    func fetchAllContent() {
        guard !isFetchingContent else { return }
        isFetchingContent = true
        service.fetchContent(requestModel: CommonRequestModel(page: page)) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let results):
                self.allContentResults.append(contentsOf: results)
                self.page += 1
                self.shouldRequestNextPage = !results.isEmpty
            case .failure(let error):
                print("Error: \(error)")
            }
            delegate?.updateCollectionView()
            isFetchingContent = false
        }
    }
}
