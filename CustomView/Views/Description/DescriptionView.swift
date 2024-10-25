//
//  DescriptionView.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 3.10.2024.
//

import UIKit

class DescriptionView: UIView {
    
    
    let label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.textAlignment = .justified
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupDescriptionLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupDescriptionLabel() {
        addSubview(label)
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor,constant: 12),
            label.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 12),
            label.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -12),
            label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12)
        ])
    }
    
    func configure(text: String) {
        label.text = text
    }
    
}
