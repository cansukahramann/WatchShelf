//
//  TrendListService.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 13.11.2024.
//

import Foundation
import Moya

final class TrendListService {
    func loadTrendingAll(requestModel: CommonRequestModel, completion: @escaping (Swift.Result<[TrendingAll], PresentableError>) -> Void) {
        NetworkManager.shared.request(TrendingAPI.trendingAll(requestModel: requestModel)) {
            let mappingResult: Result<TrendingAllModel, PresentableError> = ResponseMapper.map($0)
            completion(mappingResult.map({ $0.results }))
        }
    }
}
