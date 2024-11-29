//
//  StoreableMedia.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 5.11.2024.
//

import Foundation

struct StoreableMedia: Codable {
    let id: Int
    let title: String
    let posterPath: String?
    let type: MediaType
    let release_date: String?
    
    enum MediaType: String, Codable {
        case movie
        case tv
    }
}
