//
//  SimilarTVService.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 2.12.2024.
//

import Foundation
import Moya

struct SimilarTVService: SimilarServiceProtocol {
    private let provider = MoyaProvider<SimilarAPI>()
    
    func similarContentSelected(contentID: Int, requestModel: CommonRequestModel, completion: @escaping (Result<[SimilarResult], any Error>) -> Void) {
        provider.request(.tvShowSimilar(seriesID: contentID, requestModel: requestModel)) { result in
            switch result {
            case let .success(response):
                completion(mapResponseDetail(from: response.data))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
