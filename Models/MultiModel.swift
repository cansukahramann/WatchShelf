//
//  MultiModel.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 27.10.2024.
//

import Foundation

struct MultiModel: Codable {
    let results: [Result]
}

struct Result: Codable {
    let id: Int
    let posterPath: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case posterPath = "poster_path"
    }
}
