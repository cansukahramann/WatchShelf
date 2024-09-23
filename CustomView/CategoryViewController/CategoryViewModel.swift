//
//  CategoryViewModel.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 23.09.2024.
//

import Foundation
import Moya

protocol CategoryViewModelDelegate: AnyObject {
    func updateCollectionView()
}

class CategoryViewModel {
    weak var delegate: CategoryViewModelDelegate?
    private var provider = MoyaProvider<MovieAPI>()
    var contentResult = [ContentResult]()
        var movieAPI: MovieAPI!
    
    func request() {
        provider.request(movieAPI) { result in
            switch result {
            case .success(let response):
                let response = try! JSONDecoder().decode(ContentModel.self, from: response.data)
                self.contentResult = response.results
                self.delegate?.updateCollectionView()
            case .failure(let error):
                print(error)
            }
        }
    }
}
