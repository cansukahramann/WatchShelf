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
    let posterPath: String
    let releaseDate: String
    let runtime: Int
    let voteAverage: Double
}

struct Genres: Codable {
    let name: String
}
