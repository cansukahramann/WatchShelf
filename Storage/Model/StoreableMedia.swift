//
//  StoreableMedia.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 5.11.2024.
//

import Foundation

struct StoreableMedia: Codable {
    let id: Int
    let title: String
    let posterPath: String?
    let type: MediaType
    let releaseDate: String?
    
    enum CodingKeys: String ,CodingKey {
        case id
        case title
        case posterPath
        case type
        case releaseDate = "release_date"
    }
    
    enum MediaType: String, Codable {
        case movie
        case tv
    }
}
