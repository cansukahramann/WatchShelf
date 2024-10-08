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
    case movieSimilar(movieID: Int)
    case movieVideo(movieID: Int)
    
    case tvShowDetail(seriesID: Int)
    case tvShowCredits(seriesID: Int)
    case tvShowSimilar(seriesID: Int)
    case tvShowVideo(seriesID: Int)
    
    case peopleDetail(personID: Int)
    case peopleMovieCredits(personID: Int)
    case peopleTVCredits(personID: Int)
    
    var baseURL: URL {
        URL(string: "https://api.themoviedb.org/3")!
    }
    
    var path: String {
        switch self {
        case .movieDetail(let movieID):
            return "movie/\(movieID)"
            
        case .movieCredits(let movieID):
            return "movie/\(movieID)/credits"
            
        case .movieSimilar(let movieID):
            return "movie/\(movieID)/similar"
            
        case .movieVideo(let movieID):
            return "movie/\(movieID)/videos"
            
            
            
        case .tvShowDetail(let seriesID):
            return "tv/\(seriesID)"
            
        case .tvShowCredits(let seriesID):
            return "tv/\(seriesID)/credits"
            
        case .tvShowSimilar(let seriesID):
            return "tv/\(seriesID)/similar"
            
        case .tvShowVideo(let seriesID):
            return "tv/\(seriesID)/videos"
            
            
        case .peopleDetail(let personID):
            return "person/\(personID)"
            
        case .peopleMovieCredits(let personID):
            return "person/\(personID)/movie_credits"
            
        case .peopleTVCredits(let personID):
            return "person/\(personID)/tv_credits"
        }
    }
    
    var method: Moya.Method {
        .get
    }
    
    var task: Moya.Task {
        return .requestPlain
    }
    
    var headers: [String : String]? {
        ["Authorization" : "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJkMmMzYjU1MzcyNGFhZjI2MDJiNGUwM2U4ODEzOTY2NSIsIm5iZiI6MTcyNjk5ODU5MS43NDIzMTcsInN1YiI6IjY0ZDFkZjA4ODUwOTBmMDEyNWJlMDY4MCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.Div_QbwH9Vn2eHJuVZ3vBGuVEYusBECGaqq1j_V4GD8"]
    }
    
    
}
