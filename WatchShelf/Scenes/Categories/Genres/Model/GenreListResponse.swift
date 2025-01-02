//
//  GenreListResponse.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 11.11.2024.
//

import Foundation

struct GenreListResponse: Codable {
    let genres: [GenreResponse]
}

struct GenreResponse: Codable {
    let id: Int
    let name: String
}
