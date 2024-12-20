//
//  DiscoverAPI.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 6.11.2024.
//

import Foundation
import Moya

enum DiscoverAPI: TargetType {
    case movie(genres: [Int], requestModel: CommonRequestModel = .init())
    case tv(genres: [Int], requestModel: CommonRequestModel = .init())
    
    var path: String {
        switch self {
        case .movie:
            "discover/movie"
            
        case .tv:
            "discover/tv"
        }
    }
    
    var method: Moya.Method {
        .get
    }
    
    var task: Moya.Task {
        switch self {
        case let .movie(genreIds, requestModel),
            let .tv(genreIds, requestModel):
            var parameters = requestModel.asDictionary
            let genresString = genreIds.map { String($0) }.joined(separator: ",")
            parameters["with_genres"] = genresString
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        }
    }
}
