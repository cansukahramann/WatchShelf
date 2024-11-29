//
//  CastCredits.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 25.10.2024.
//

import Foundation

struct CastCredits: Codable {
    let cast: [CastCredit]
}

struct CastCredit: Codable {
    let id: Int
    let posterPath: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case posterPath = "poster_path"
    }
}
