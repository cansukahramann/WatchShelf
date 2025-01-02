//
//  TrendingResponse.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 31.10.2024.
//

import Foundation

struct TrendingResponse: Decodable {
    let results: [TrendingAll]
}

struct TrendingAll: Decodable {
    let posterPath: String?
    let id: Int
    let mediaType: String
    
    var type: MediaType? {
        switch mediaType {
        case "movie":
            return .movie
        case "tv":
            return .tv
        default:
            return nil
        }
    }
}

enum MediaType {
    case movie
    case tv
}
