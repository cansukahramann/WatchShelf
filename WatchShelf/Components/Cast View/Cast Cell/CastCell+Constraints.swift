//
//  CastCell+Constraints.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 2.01.2025.
//

import UIKit

extension CastCell {
    func setupConstraint() {
        contentView.addSubviews(posterImageView, castRealName,castMovieName)
    
        NSLayoutConstraint.activate( [
            posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            posterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            posterImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            posterImageView.heightAnchor.constraint(equalTo: posterImageView.widthAnchor),
            
            castRealName.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: 2),
            castRealName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            castRealName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            castMovieName.topAnchor.constraint(equalTo: castRealName.bottomAnchor),
            castMovieName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            castMovieName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            castMovieName.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
            
        ])
    }
}
