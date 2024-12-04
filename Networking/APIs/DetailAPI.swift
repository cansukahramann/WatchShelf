//
//  DetailAPI.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 23.09.2024.
//

import Foundation
import Moya


enum DetailAPI: TargetType {
    case movieDetail(movieID: Int)
    case movieCredits(movieID: Int)
    case movieVideo(movieID: Int)
    
    case tvShowDetail(tvShowID: Int)
    case tvShowCredits(tvShowID: Int)
    case tvShowVideo(tvShowID: Int)
    
    case peopleDetail(castID: Int)
    case peopleMovieCredits(castID: Int)
    case peopleTVCredits(castID: Int)
    
    var baseURL: URL {
        URL(string: "https://api.themoviedb.org/3")!
    }
    
    var path: String {
        switch self {
        case .movieDetail(let movieID):
            return "movie/\(movieID)"
            
        case .movieCredits(let movieID):
            return "movie/\(movieID)/credits"
            
        case .movieVideo(let movieID):
            return "movie/\(movieID)/videos"
            
            
            
        case .tvShowDetail(let tvShowID):
            return "tv/\(tvShowID)"
            
        case .tvShowCredits(let tvShowID):
            return "tv/\(tvShowID)/credits"
            
        case .tvShowVideo(let tvShowID):
            return "tv/\(tvShowID)/videos"
            
            
        case .peopleDetail(let castID):
            return "person/\(castID)"
            
        case .peopleMovieCredits(let castID):
            return "person/\(castID)/movie_credits"
            
        case .peopleTVCredits(let castID):
            return "person/\(castID)/tv_credits"
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
