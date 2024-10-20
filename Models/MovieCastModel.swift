//
//  MovieCast.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 20.10.2024.
//

import Foundation

struct MovieCastModel: Codable {
    let id: Int?
    let cast: [Cast]
}

struct Cast: Codable {
    let id: Int
    let name: String
    let profilePath: String?
    let character: String
    let castId: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case profilePath = "profile_path"
        case character
        case castId = "cast_id"
    }
}
