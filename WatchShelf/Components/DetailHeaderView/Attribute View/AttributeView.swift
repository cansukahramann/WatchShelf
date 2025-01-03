//
//  AttributeView.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 2.10.2024.
//

import UIKit

final class AttributeView: UIView {
    let attributeImage = UIImageView()
    let attributeLabel = UILabel(textColor:.secondaryLabel, font: UIFont.systemFont(ofSize: 15), numberOfLines: 0, textAlignment: .left)
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        attributeImage.translatesAutoresizingMaskIntoConstraints = false
        attributeImage.tintColor = .secondaryLabel
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
