//
//  DiscoverResponse.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 8.11.2024.
//

import Foundation

struct DiscoverResponse: Decodable {
    let results: [DiscoverResult]
}

struct DiscoverResult: Decodable {
    let id: Int
    let title: String?
    let name: String?
    let voteAverage: Double?
    let posterPath: String?
    let genreIds: [Int]
    
    var isMovie: Bool {
        return title != nil
    }
    
    var isTVShow: Bool {
        return name != nil
    }
    
}
