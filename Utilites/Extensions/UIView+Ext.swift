//
//  UIView+Ext.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 3.12.2024.
//

import UIKit

extension UIView {
    func addSubviews(_ subviews: UIView...) {
        subviews.forEach { addSubview($0) }
    }
}
