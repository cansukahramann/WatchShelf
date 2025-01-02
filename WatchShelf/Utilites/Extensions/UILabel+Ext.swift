//
//  UILabel+Ext.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 2.01.2025.
//

import UIKit

extension UILabel {
    convenience init(text: String? = nil, textColor: UIColor? = .label, font: UIFont? = nil, numberOfLines: Int? = nil, textAlignment: NSTextAlignment? = nil) {
        self.init(frame: .zero)
        self.text = text
        self.textColor = textColor
        
        if let font { self.font = font }
        if let numberOfLines {
            self.numberOfLines = numberOfLines
            
            if numberOfLines == 1 {
                adjustsFontSizeToFitWidth = true
                minimumScaleFactor = 0.5
            }
        }
        if let textAlignment { self.textAlignment = textAlignment }
        
        translatesAutoresizingMaskIntoConstraints = false
    }
}
