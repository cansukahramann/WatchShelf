//
//  SearchResponse.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 3.11.2024.
//

import Foundation

struct SearchResponse: Decodable {
    let results: [SearchResult]
}

struct SearchResult: Decodable {
    let id: Int
    let posterPath: String?
    let mediaType: MediaType
    let releaseDate: String?
    let title: String?
    let name: String?
    
    enum MediaType: String, Decodable {
        case movie
        case tv
        case person
    }
}




