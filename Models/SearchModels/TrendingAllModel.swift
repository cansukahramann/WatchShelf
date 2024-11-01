//
//  TrendingAllModel.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 31.10.2024.
//

import Foundation

struct TrendingAllModel: Codable {
    let results: [TrendingAll]
}

struct TrendingAll: Codable {
    let posterPath: String?
    let id: Int
    let mediaType: String
    
    enum CodingKeys: String, CodingKey {
        case posterPath = "poster_path"
        case id
        case mediaType = "media_type"
        
    }
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
