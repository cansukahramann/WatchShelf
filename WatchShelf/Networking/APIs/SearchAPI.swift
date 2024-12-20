//
//  SearchAPI.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 27.10.2024.
//

import Foundation
import Moya

enum SearchAPI: TargetType {
    case multi(query: String, requestModel: CommonRequestModel = .init())

    var path: String {
        "search/multi"
    }
    
    var method: Moya.Method {
        .get
    }
    
    var task: Moya.Task {
        switch self {
        case let .multi(query, requestModel):
            var parameters = requestModel.asDictionary
            parameters["query"] = query
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)

        }
    }
}
