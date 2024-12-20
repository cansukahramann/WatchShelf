//
//  Label.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 9.12.2024.
//

import UIKit

final class Label: UILabel {
    convenience init(text: String? = nil, textColor: UIColor? = nil, font: UIFont? = nil, numberOfLines: Int? = nil, textAlignment: NSTextAlignment? = nil) {
        self.init(frame: .zero)
        self.text = text
        
        if let textColor { self.textColor = textColor }
        if let font { self.font = font }
        if let numberOfLines {
            self.numberOfLines = numberOfLines
            
            if numberOfLines == 1 {
                adjustsFontSizeToFitWidth = true
                minimumScaleFactor = 0.5
            }
        }
        if let textAlignment { self.textAlignment = textAlignment }
    }
}
