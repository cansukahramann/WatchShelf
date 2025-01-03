//
//  AttributeView+Constraints.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 3.01.2025.
//

import UIKit

extension AttributeView {
    func setupConstraints() {
        addSubview(attributeImage)
        addSubview(attributeLabel)
        
        NSLayoutConstraint.activate([
            attributeImage.widthAnchor.constraint(equalToConstant: 16),
            attributeImage.heightAnchor.constraint(equalToConstant: 16),
            attributeImage.topAnchor.constraint(equalTo: topAnchor),
            attributeImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            
            attributeLabel.topAnchor.constraint(equalTo: topAnchor),
            attributeLabel.leadingAnchor.constraint(equalTo: attributeImage.trailingAnchor, constant: 3),
            attributeLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 3),
            attributeLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
