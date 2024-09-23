//
//  CategoryViewModel.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 23.09.2024.
//

import Foundation
import Moya

class CategoryViewModel {
    
    var provider = MoyaProvider<MovieAPI>()
    var contentModel: ContentModel!
    var movieAPI: MovieAPI!
    
    func request() {
        provider.request(movieAPI) { result in
            switch result {
            case .success(let response):
                let response = try! JSONDecoder().decode(ContentModel.self, from: response.data)
                self.contentModel = response
                print(self.contentModel.results!)
            case .failure(let error):
                print(error)
            }
        }
    }
}
