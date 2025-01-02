//
//  MovieCastResponse.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 20.10.2024.
//

import Foundation

struct MovieCastResponse: Decodable {
    let id: Int
    let cast: [CastMember]
}

struct CastMember: Decodable {
    let id: Int
    let name: String
    let profilePath: String?
    let character: String
}
