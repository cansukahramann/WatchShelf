//
//  CastDetailResponse.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 21.10.2024.
//

import Foundation

struct  CastDetailResponse: Decodable {
    let biography: String?
    let birthday: String?
    let id: Int
    let name: String
    let placeOfBirthday: String?
    let profilePath: String?
}
