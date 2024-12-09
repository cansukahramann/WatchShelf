//
//  ContentAPI.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 22.09.2024.
//

import Foundation
import Moya
 
enum ContentAPI: TargetType {
    case popularMovie(CommonRequestModel = .init())
    case nowPlayingMovie(CommonRequestModel = .init())
    case upcomingMovie(CommonRequestModel = .init())
    case topRatedMovie(CommonRequestModel = .init())
    
    case airingTodayTVShow(CommonRequestModel = .init())
    case onTheAirTVShow(CommonRequestModel = .init())
    case popularTVShow(CommonRequestModel = .init())
    case topRatedTVShow(CommonRequestModel = .init())
    
    var path: String {
        switch self {
        case .popularMovie:
            return "movie/popular"
        case .nowPlayingMovie:
            return "movie/now_playing"
        case .upcomingMovie:
            return "movie/upcoming"
        case .topRatedMovie:
            return "movie/top_rated"
            
        case .airingTodayTVShow:
            return "tv/airing_today"
        case .onTheAirTVShow:
            return "tv/on_the_air"
        case .popularTVShow:
            return "tv/popular"
        case .topRatedTVShow:
            return "tv/top_rated"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var task: Moya.Task {
        switch self {
        case let .popularMovie(requestModel),
                 let .nowPlayingMovie(requestModel),
                 let .upcomingMovie(requestModel),
                 let .topRatedMovie(requestModel),
                 let .airingTodayTVShow(requestModel),
                 let .onTheAirTVShow(requestModel),
                 let .popularTVShow(requestModel),
                 let .topRatedTVShow(requestModel):
                return .requestParameters(parameters: requestModel.asDictionary, encoding: URLEncoding.queryString)
        }
    }
}


