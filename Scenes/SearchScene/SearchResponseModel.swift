//
//  SearchResponseModel.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 3.11.2024.
//

import Foundation

struct SearchResponseModel: Decodable {
    struct Result: Decodable {
        let id: Int
        let poster_path: String?
        let media_type: MediaType
        let release_date: String?
        let title: String?
    }
    
    enum MediaType: String, Decodable {
        case movie
        case tv
        case person
    }
    
    let results: [Result]
}
