//
//  SearchAPI.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 27.10.2024.
//

import Foundation
import Moya

enum SearchAPI: TargetType {
    
    case searchMulti
    case searchTV
    case searchMovie
    case searchPerson
    
    
    var baseURL: URL {
        URL(string: "https://api.themoviedb.org/3/search")!
    }
    
    var path: String {
        switch self {
        case .searchMulti:
            "multi"
        case .searchTV:
            "tv"
        case .searchMovie:
            "movie"
        case .searchPerson:
            "person"
        }
    }
    
    var method: Moya.Method {
        .get
    }
    
    var task: Moya.Task {
        return.requestPlain
    }
    
    var headers: [String : String]? {
        ["Authorization" : "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJkMmMzYjU1MzcyNGFhZjI2MDJiNGUwM2U4ODEzOTY2NSIsIm5iZiI6MTcyNjk5ODU5MS43NDIzMTcsInN1YiI6IjY0ZDFkZjA4ODUwOTBmMDEyNWJlMDY4MCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.Div_QbwH9Vn2eHJuVZ3vBGuVEYusBECGaqq1j_V4GD8"]
    }
    
    
}
