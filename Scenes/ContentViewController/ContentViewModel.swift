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
    private let service: ContentService
    
    var allContentResults = [ContentResult]()
    
    init(service: ContentService) {
        self.service = service
    }
    
    func fetchAllContent() {
        
        service.loadContent { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let results):
                self.allContentResults.append(contentsOf: results)
            case .failure(let error):
                print("Error: \(error)")
            }
            delegate?.updateCollectionView()
        }
    }
}
