//
//  AiringTodayMediaService.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 26.11.2024.
//

import Foundation
import Moya

struct AiringTodayMediaService: MediaServiceProtocol {
    func fetchMedia(requestModel: CommonRequestModel, completion: @escaping (Result<[Media], any Error>) -> Void) {
        NetworkManager.shared.request(ContentAPI.airingTodayTVShow(requestModel)) { result in
            switch result {
            case let .success(response):
                completion(map(data: response.data))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
