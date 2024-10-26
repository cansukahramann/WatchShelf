//
//  MovieVideoModel.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 20.10.2024.
//

import Foundation

struct MovieVideoModel: Codable {
    let results: [Results]
}
struct Results: Codable {
    let key: String
}
