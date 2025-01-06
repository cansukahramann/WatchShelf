//
//  VideoResponse.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 20.10.2024.
//

import Foundation

struct VideoResponse: Codable {
    let results: [VideoItem]
}
struct VideoItem: Codable {
    let key: String
}
