//
//  TVShowCastResponse.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 26.10.2024.
//

import Foundation

struct TVShowCastResponse: Codable {
    let cast: [SeriesCast]
}

struct SeriesCast: Codable {
    let id: Int
    let name: String
    let profilePath: String?
    let character: String
    
    enum CodingKeys: String, CodingKey {
        case id, name, character
        case profilePath = "profile_path"
    }
}
