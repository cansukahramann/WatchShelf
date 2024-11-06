//
//  TVShowDetailModel.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 22.10.2024.
//

import Foundation

struct TVShowDetailModel: Codable {
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
    
    enum CodingKeys: String, CodingKey {
        case id, name, overview, genres, status
        case firstAirDate = "first_air_date"
        case lastAirDate = "last_air_date"
        case posterPath = "poster_path"
        case numberOfSeasons = "number_of_seasons"
        case voteAverage = "vote_average"
    }
}

struct Genre: Codable {
    let name: String
}
