//
//  NowPlayingContentService.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 25.11.2024.
//

import Moya

struct NowPlayingContentService: ContentServiceProtocol {
    private let provider = MoyaProvider<ContentAPI>()
    
    func fetchContent(requestModel: CommonRequestModel, completion: @escaping (Result<[ContentResult], any Error>) -> Void) {
        provider.request(.nowPlayingMovie(requestModel)) { result in
            switch result {
            case let .success(response):
                completion(map(data: response.data))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
