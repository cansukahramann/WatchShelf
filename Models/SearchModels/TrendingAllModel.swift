//
//  TrendingAllModel.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 31.10.2024.
//

import Foundation

struct TrendingAllModel: Codable {
    let results: [TrendingAll]
}

struct TrendingAll: Codable {
    let posterPath: String?
    let id: Int
    
    
    enum CodingKeys: String, CodingKey {
        case posterPath = "poster_path"
        case id 
 
    }
}
