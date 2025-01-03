//
//  DetailHeaderView+Constraints.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 3.01.2025.
//

import UIKit

extension DetailHeaderView {
    func setupConstraints() {
        addSubviews(titleLabel, posterImageView, stackView)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -4),
            titleLabel.bottomAnchor.constraint(equalTo: stackView.topAnchor, constant: -12),
            
            posterImageView.topAnchor.constraint(equalTo: topAnchor),
            posterImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            posterImageView.widthAnchor.constraint(equalToConstant: 192),
            posterImageView.heightAnchor.constraint(equalToConstant: 240),
            posterImageView.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: 0),
            
            stackView.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor)
        ])
    }
}
