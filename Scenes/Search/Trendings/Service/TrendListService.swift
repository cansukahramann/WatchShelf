//
//  TrendListService.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 13.11.2024.
//

import Foundation
import Moya

final class TrendListService {
    func loadTrendingAll(requestModel: CommonRequestModel,completion: @escaping (Swift.Result<[TrendingAll], Error>) -> Void) {
        NetworkManager.shared.request(TrendingAPI.trendingAll(requestModel: requestModel)) { result in
            switch result {
            case .success(let response):
                completion(TrendListService.map(response: response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private static func map(response: Moya.Response) -> Swift.Result<[TrendingAll], Error> {
        do {
            let decoder = JSONDecoder()
            let decodedModel = try decoder.decode(TrendingAllModel.self, from: response.data)
            return .success(decodedModel.results)
        } catch {
            return .failure(error)
        }
    }
}
