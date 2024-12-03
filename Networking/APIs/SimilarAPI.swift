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
    case tvShowSimilar(seriesID: Int,requestModel:CommonRequestModel = .init())
    
    var baseURL: URL {
        URL(string: "https://api.themoviedb.org/3")!
    }
    
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
        default:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        ["Authorization" : "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJkMmMzYjU1MzcyNGFhZjI2MDJiNGUwM2U4ODEzOTY2NSIsIm5iZiI6MTcyNjk5ODU5MS43NDIzMTcsInN1YiI6IjY0ZDFkZjA4ODUwOTBmMDEyNWJlMDY4MCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.Div_QbwH9Vn2eHJuVZ3vBGuVEYusBECGaqq1j_V4GD8"]
    }

}
