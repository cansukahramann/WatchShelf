//
//  SimilarAPI.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 2.12.2024.
//

import Foundation
import Moya

enum SimilarAPI: TargetType {
    case movieSimilar(movieID: Int, requestModel:CommonRequestModel = .init())
    case tvShowSimilar(seriesID: Int, requestModel:CommonRequestModel = .init())
  
    var path: String {
        switch self {
        case .movieSimilar(let movieID, _):
            return "movie/\(movieID)/similar"
            
        case .tvShowSimilar(let seriesID, _):
            return "tv/\(seriesID)/similar"
        }
    }
    
    var method: Moya.Method {
        .get
    }
    
    var task: Moya.Task {
        switch self {
        case .movieSimilar(_, let requestModel):
            return .requestParameters(parameters: requestModel.asDictionary, encoding: URLEncoding.default)
        case .tvShowSimilar(_ , let requestModel):
            return .requestParameters(parameters: requestModel.asDictionary, encoding: URLEncoding.default)
        }
    }
}
