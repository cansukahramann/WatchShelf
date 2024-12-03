//
//  Encodable+Ext.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 25.11.2024.
//

import Foundation

extension Encodable {
    var asDictionary: [String: Any] {
        guard let data = try? JSONEncoder().encode(self),
              let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else {
            return [:]
        }
        return json
    }
}
