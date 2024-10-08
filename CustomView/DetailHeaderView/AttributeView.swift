//
//  AttributeView.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 2.10.2024.
//

import UIKit

class AttributeView: UIView {
    
    let attributeImage = UIImageView()
    let attributeLabel = EventLabel(textAlignment: .left, fontSize: 16)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureImage()
        configureLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureImage() {
        addSubview(attributeImage)
        attributeImage.translatesAutoresizingMaskIntoConstraints = false
        attributeImage.tintColor = .red
        
        NSLayoutConstraint.activate([
            attributeImage.widthAnchor.constraint(equalToConstant: 16),
            attributeImage.heightAnchor.constraint(equalToConstant: 16),
            attributeImage.topAnchor.constraint(equalTo: topAnchor),
            attributeImage.leadingAnchor.constraint(equalTo: leadingAnchor)
        ])
    }
    
    private func configureLabel() {
        addSubview(attributeLabel)
        attributeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            attributeLabel.topAnchor.constraint(equalTo: topAnchor),
            attributeLabel.leadingAnchor.constraint(equalTo: attributeImage.trailingAnchor, constant: 3),
            attributeLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 3),
            attributeLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
}
