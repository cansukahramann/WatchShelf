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

    var path: String {
        switch self {
        case .movie:
            "genre/movie/list"
            
        case .tv:
            "genre/tv/list"
        }
    }
    
    var method: Moya.Method {
        .get
    }
    
    var task: Moya.Task {
        .requestPlain
    }
}
