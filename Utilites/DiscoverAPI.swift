//
//  DiscoverAPI.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 6.11.2024.
//

import Foundation
import Moya

enum DiscoverAPI: TargetType {
    
    case movie(genres: [Int])
    case tv(genres: [Int])
    
    
    var baseURL: URL {
        URL(string: "https://api.themoviedb.org/3/discover")!
    }
    
    var path: String {
        switch self {
        case .movie:
            "movie"
        case .tv:
            "tv"
        }
    }
    
    var method: Moya.Method {
        .get
    }
    
    var task: Moya.Task {
        switch self {
        case .movie(let genreIds), .tv(let genreIds):
            let genresString = genreIds.map { String($0) }.joined(separator: ",")
            return .requestParameters(parameters: ["with_genres": genresString], encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        ["Authorization" : "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJkMmMzYjU1MzcyNGFhZjI2MDJiNGUwM2U4ODEzOTY2NSIsIm5iZiI6MTcyNjk5ODU5MS43NDIzMTcsInN1YiI6IjY0ZDFkZjA4ODUwOTBmMDEyNWJlMDY4MCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.Div_QbwH9Vn2eHJuVZ3vBGuVEYusBECGaqq1j_V4GD8"]
    }
}
