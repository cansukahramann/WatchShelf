//
//  AiringTodayContentService.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 26.11.2024.
//

import Foundation
import Moya

struct AiringTodayContentService: ContentServiceProtocol {
    private let provider = MoyaProvider<ContentAPI>()
    
    func fetchContent(requestModel: CommonRequestModel, completion: @escaping (Result<[ContentResult], any Error>) -> Void) {
        provider.request(.airingTodayTVShow(requestModel)) { result in
            switch result {
            case let .success(response):
                completion(map(data: response.data))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
