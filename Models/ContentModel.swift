//
//  ContentModel.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 22.09.2024.
//

import Foundation

struct ContentModel: Codable{
    let page: Int
    let results: [ContentResult]
}

struct ContentResult: Codable {
    let id: Int 
    let posterPath: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case posterPath = "poster_path"
    }
}
