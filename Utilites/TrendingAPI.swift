//
//  TrendingAPI.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 30.10.2024.
//

import Foundation
import Moya

enum TrendingAPI: TargetType {
    
    case trendingAll
    case trendingMovie
    case trendingPeople
    case trendingTv
    
    
    var baseURL: URL {
        URL(string: "https://api.themoviedb.org/3/trending")!
    }
    
    var path: String {
        switch self {
        case .trendingAll:
            "all/day"
        case .trendingMovie:
           "movie/day"
        case .trendingPeople:
            "person/day"
        case .trendingTv:
            "tv/day"
        }
    }
    
    var method: Moya.Method {
        .get
    }
    
    var task: Moya.Task {
        .requestPlain
    }
    
    var headers: [String : String]? {
        ["Authorization" : "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJkMmMzYjU1MzcyNGFhZjI2MDJiNGUwM2U4ODEzOTY2NSIsIm5iZiI6MTcyNjk5ODU5MS43NDIzMTcsInN1YiI6IjY0ZDFkZjA4ODUwOTBmMDEyNWJlMDY4MCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.Div_QbwH9Vn2eHJuVZ3vBGuVEYusBECGaqq1j_V4GD8"]
    }
    
    
}
