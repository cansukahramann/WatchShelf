//
//  MediaResponse.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 22.09.2024.
//

import Foundation

struct MediaResponse: Decodable{
    let page: Int
    let results: [Media]
}

struct Media: Decodable {
    let id: Int 
    let posterPath: String?
}
