//
//  PopularMediaService.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 25.11.2024.
//

import Moya

struct PopularMediaService: MediaServiceProtocol {
    func fetchMedia(requestModel: CommonRequestModel, completion: @escaping (Result<[Media], any Error>) -> Void) {
        NetworkManager.shared.request(ContentAPI.popularMovie(requestModel)) { result in
            switch result {
            case let .success(response):
                completion(map(data: response.data))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
