//
//  ContentService.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 13.11.2024.
//

import Foundation
import Moya

final class ContentService {
    private let provider = MoyaProvider<ContentAPI>()
    private let endpoint: ContentAPI
    
    init(endpoint: ContentAPI) {
        self.endpoint = endpoint
    }

    func loadContent(completion: @escaping (Swift.Result<[ContentResult], Error>) -> Void) {
        provider.request(endpoint) { result in
            switch result {
            case .success(let response):
                completion(ContentService.map(response: response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
        private static func map(response: Moya.Response) -> Swift.Result<[ContentResult], Error> {
            do {
                let decoder = JSONDecoder()
                let decodedModel = try decoder.decode(ContentModel.self, from: response.data)
                return(.success(decodedModel.results))
            } catch {
                return(.failure(error))
            }
        }
    
    
}
