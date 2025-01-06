//
//  TVShowDetails.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 22.10.2024.
//

import Foundation

struct TVShowDetails: Decodable {
    let id: Int
    let name: String
    let overview: String
    let firstAirDate: String?
    let lastAirDate: String?
    let posterPath: String?
    let genres: [Genre]
    let numberOfSeasons: Int
    let voteAverage: Double
    let status: String
}

struct Genre: Decodable {
    let name: String
}
