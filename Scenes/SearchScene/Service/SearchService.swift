//
//  SearchService.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 3.11.2024.
//

import Foundation
import Moya

final class SearchService {
    private let provider = MoyaProvider<SearchAPI>()
    
    func search(searchText: String,requestModel: CommonRequestModel, completion: @escaping (Result<SearchResponseModel, Error>) -> Void) {
        provider.request(.multi(query: searchText, requestModel: requestModel)) { result in
            switch result {
            case .success(let response):
                completion(SearchService.map(response: response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private static func map(response: Moya.Response) -> Swift.Result<SearchResponseModel, Error> {
        do {
            let decoder = JSONDecoder()
            let decodedModel = try decoder.decode(SearchResponseModel.self, from: response.data)
            return .success(decodedModel)
        } catch {
            return .failure(error)
        }
    }
}
