//
//  TVShowCastResponse.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 26.10.2024.
//

import Foundation

struct TVShowCastResponse: Decodable {
    let cast: [SeriesCast]
}

struct SeriesCast: Decodable {
    let id: Int
    let name: String
    let profilePath: String?
    let character: String
}
