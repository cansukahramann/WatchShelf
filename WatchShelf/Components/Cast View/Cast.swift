//
//  Cast.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 2.01.2025.
//

import Foundation

struct Cast {
    let id: Int
    let realName: String
    let characterName: String
    private let imagePath: String?
    
    init(id: Int, realName: String, characterName: String, imagePath: String?) {
        self.id = id
        self.realName = realName
        self.characterName = characterName
        self.imagePath = imagePath
    }
    
    var imageURL: URL? {
        guard let imagePath else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/w500" + imagePath)
    }
}
