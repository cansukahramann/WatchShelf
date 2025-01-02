//
//  CastDetailResponse.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 21.10.2024.
//

import Foundation

struct  CastDetailResponse: Codable {
    let biography: String?
    let birthday: String?
    let id: Int
    let name: String
    let placeOfBirthday: String?
    let profilePath: String?
    
    enum CodingKeys: String, CodingKey {
        case biography, birthday, id, name
        case placeOfBirthday = "place_of_birth"
        case profilePath = "profile_path"
    }
}
