//
//  TrendingAPI.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 30.10.2024.
//

import Foundation
import Moya

enum TrendingAPI: TargetType {
    case trendingAll(requestModel:CommonRequestModel = .init())
  
    var path: String {
        "trending/all/day"
    }
    
    var method: Moya.Method {
        .get
    }
    
    var task: Moya.Task {
        switch self {
        case let .trendingAll(requestModel: requestModel):
            return .requestParameters(parameters: requestModel.asDictionary, encoding: URLEncoding.queryString)
        }
    }
}
