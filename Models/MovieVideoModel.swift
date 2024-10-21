//
//  MovieVideoModel.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 20.10.2024.
//

import Foundation

struct MovieVideoModel: Codable {
    let results: [MovieVideo]
}
struct MovieVideo: Codable {
    let key: String
}
