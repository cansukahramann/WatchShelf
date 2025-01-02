//
//  CastCredits.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 25.10.2024.
//

import Foundation

struct CastCredits: Decodable {
    let cast: [CastCredit]
}

struct CastCredit: Decodable {
    let id: Int
    let posterPath: String?
}
