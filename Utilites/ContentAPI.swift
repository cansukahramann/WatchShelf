//
//  ContentAPI.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 22.09.2024.
//

import Foundation
import Moya

enum ContentAPI: TargetType {
    case popularMovie
    case nowPlayingMovie
    case upcomingMovie
    case topRatedMovie
    
    case airingTodayTVShow
    case onTheAirTVShow
    case popularTVShow
    case topRatedTVShow
    
    var baseURL: URL {
        URL(string: "https://api.themoviedb.org/3")!
    }
    
    var path: String {
        switch self {
        case .popularMovie:
            "movie/popular"
        case .nowPlayingMovie:
            "movie/now_playing"
        case .upcomingMovie:
            "movie/upcoming"
        case .topRatedMovie:
            "movie/top_rated"
            
        case .airingTodayTVShow:
            "tv/airing_today"
        case .onTheAirTVShow:
            "tv/on_the_air"
        case .popularTVShow:
            "tv/popular"
        case .topRatedTVShow:
            "tv/top_rated"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var task: Moya.Task {
        return .requestPlain
    }
    
    var headers: [String : String]? {
        ["Authorization" : "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJkMmMzYjU1MzcyNGFhZjI2MDJiNGUwM2U4ODEzOTY2NSIsIm5iZiI6MTcyNjk5ODU5MS43NDIzMTcsInN1YiI6IjY0ZDFkZjA4ODUwOTBmMDEyNWJlMDY4MCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.Div_QbwH9Vn2eHJuVZ3vBGuVEYusBECGaqq1j_V4GD8"]
    }
}
