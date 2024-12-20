//
//  PresentableError.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 16.12.2024.
//

import Foundation

struct PresentableError: Error {
    let message: String
    let title: String
    
    init(message: String, title: String) {
        self.message = message
        self.title = title
    } 
    static let generic = PresentableError(message: "Something went wrong", title: "Error")
}
