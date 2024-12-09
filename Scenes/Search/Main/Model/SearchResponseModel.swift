//
//  SearchResponseModel.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 3.11.2024.
//

import Foundation

struct SearchResponseModel: Decodable {
    let results: [Result]
    
    struct Result: Decodable {
        let id: Int
        let posterPath: String?
        let mediaType: MediaType
        let releaseDate: String?
        let title: String?
        let name: String?
        
        enum CodingKeys: String, CodingKey {
            case id, title, name
            case posterPath = "poster_path"
            case mediaType = "media_type"
            case releaseDate = "release_date"

        }
        
        enum MediaType: String, Decodable {
            case movie
            case tv
            case person
        }

    }
}





