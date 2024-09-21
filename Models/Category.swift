//
//  Category.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 17.09.2024.
//

import UIKit

struct Category {
    var title: String
    var image: UIImage!
//    var url: URL
    
    init(title: String, image: UIImage!) {
        self.title = title
        self.image = image
    }
    
    init(image: UIImage) {
        self.title = ""
        self.image = image
    }
}
