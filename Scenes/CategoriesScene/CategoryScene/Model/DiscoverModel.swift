//
//  DiscoverModel.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 8.11.2024.
//

import Foundation

struct DiscoverModel: Codable {
    let results: [DiscoverResult]
}

struct DiscoverResult: Codable {
    let id: Int
    let title: String?
    let name: String?
    let voteAverage: Double?
    let posterPath: String?
    let genreIds: [Int]
    
    enum CodingKeys: String, CodingKey {
        case id, title, name 
        case voteAverage = "vote_average"
        case posterPath = "poster_path"
        case genreIds = "genre_ids"
    }
    
    var isMovie: Bool {
        return title != nil
    }
    
    var isTVShow: Bool {
        return name != nil
    }
    
}
