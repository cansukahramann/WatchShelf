//
//  CommonRequestModel.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 9.12.2024.
//

import Foundation

struct CommonRequestModel: Encodable {
    let page: Int
    let includeAdult: Bool
    
    enum CodingKeys: String, CodingKey {
        case page
        case includeAdult = "include_adult"
    }
    
    init(page: Int = 1, includeAdult: Bool = false) {
        self.page = page
        self.includeAdult = includeAdult
    }
}
