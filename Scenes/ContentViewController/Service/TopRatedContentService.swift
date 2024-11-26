//
//  TopRatedContentService.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 25.11.2024.
//

import Foundation
import Moya

struct TopRatedContentService: ContentServiceProtocol {
    private let provider = MoyaProvider<ContentAPI>()
    
    func fetchContent(requestModel: CommonRequestModel, completion: @escaping (Result<[ContentResult], any Error>) -> Void) {
        provider.request(.topRatedMovie(requestModel)) { result in
            switch result {
            case let .success(response):
                completion(map(data: response.data))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}


