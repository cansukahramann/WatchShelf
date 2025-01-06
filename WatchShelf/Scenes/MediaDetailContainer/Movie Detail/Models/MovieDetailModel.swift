//
//  MovieDetailModel.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 23.09.2024.
//

import Foundation

struct MovieDetailModel: Decodable {
    let id: Int
    let title: String
    let overview: String
    let releaseDate: String
    let posterPath: String?
    let genres: [Genres]
    let runtime: Int
    let voteAverage: Double
}

struct Genres: Decodable {
    let name: String
}

struct DetailModel {
    let id: Int
    let title: String
    let overview: String
    let posterPath: String?
    let attributes: [AttributeModel]
}

struct AttributeModel {
    let name: String
    let image: String
}
