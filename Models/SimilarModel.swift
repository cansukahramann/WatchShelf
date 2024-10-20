//
//  SimilarModel.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 11.10.2024.
//

import Foundation

struct SimilarModel: Codable {
    let page: Int
    let results: [SimilarResult]
}

struct SimilarResult: Codable {
    let id: Int
    let posterPath: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case posterPath = "poster_path"
    }
}
