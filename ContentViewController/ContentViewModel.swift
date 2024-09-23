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

class ContentViewModel {
    weak var delegate: ContentViewModelDelegate?
    private let provider = MoyaProvider<ContentAPI>()
    
    var contentResult = [ContentResult]()
    private let contentAPI: ContentAPI
    
    init(contentAPI: ContentAPI) {
        self.contentAPI = contentAPI
    }
    
    func fetchContent() {
        provider.request(contentAPI) { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let response):
                contentResult = mapResponse(from: response.data)
                delegate?.updateCollectionView()
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func mapResponse(from data: Data) -> [ContentResult] {
        let response = try! JSONDecoder().decode(ContentModel.self, from: data)
        return response.results
    }
}
