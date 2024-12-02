//
//  SimilarService.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 30.11.2024.
//

import Foundation
import Moya

struct SimilarService: SimilarServiceProtocol {
    private let provider = MoyaProvider<SimilarAPI>()
   
    func similarContentSelected(contentID: Int, requestModel: CommonRequestModel, completion: @escaping (Result<[SimilarResult], any Error>) -> Void) {
        provider.request(.movieSimilar(movieID: contentID, requestModel: requestModel)) { result in
            switch result {
            case let .success(response):
                completion(mapResponseDetail(from: response.data))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
