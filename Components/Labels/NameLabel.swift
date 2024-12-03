//
//  NameLabel.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 9.10.2024.
//

import UIKit

final class NameLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(textColor: UIColor , fontSize: CGFloat) {
        self.init(frame: .zero)
        self.textColor = textColor
        self.font = UIFont.systemFont(ofSize: fontSize)
    }
    
    private func configure() {
        textAlignment = .center
        numberOfLines = 1
        translatesAutoresizingMaskIntoConstraints = false
    }
    
}
