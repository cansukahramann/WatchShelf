//
//  MovieDetailModel.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 23.09.2024.
//

import Foundation

struct MovieDetailModel: Decodable {
    let genres: [Genres]
    let id: Int
    let title: String
    let overview: String
    let posterPath: String?
    let releaseDate: String
    let runtime: Int
    let voteAverage: Double
}

struct Genres: Decodable {
    let id: Int
    let name: String
}
