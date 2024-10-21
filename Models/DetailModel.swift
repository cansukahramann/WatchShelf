//
//  DetailModel.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 23.09.2024.
//

import Foundation

struct DetailModel: Codable {
    let genres: [Genres]
    let id: Int
    let title: String
    let overview: String
    let posterPath: String?
    let releaseDate: String
    let runtime: Int
    let voteAverage: Double
    
    enum CodingKeys: String, CodingKey {
        case id,title,overview,runtime,genres
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
    }
}

struct Genres: Codable {
    let id: Int
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case id,name
    }
}
