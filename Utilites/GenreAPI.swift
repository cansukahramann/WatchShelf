//
//  GenreAPI.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 11.11.2024.
//

import Foundation
import Moya

enum GenreAPI: TargetType {
    
    case movie
    case tv
    
    var baseURL: URL {
        URL(string: "https://api.themoviedb.org/3/genre")!
    }
    
    var path: String {
        switch self {
        case .movie:
            "movie/list"
        case .tv:
            "tv/list"
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
