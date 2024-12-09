//
//  UIStackView+Ext.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 9.12.2024.
//

import UIKit

extension UIStackView {
    func addArrangedSubviews(_ subviews: UIView...) {
        subviews.forEach { subview in
            addArrangedSubview(subview)
        }
    }
}
