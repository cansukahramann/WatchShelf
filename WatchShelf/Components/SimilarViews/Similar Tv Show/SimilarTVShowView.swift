//
//  SimilarTVShowView.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 26.10.2024.
//

import UIKit

final class SimilarTVShowView: BaseSimilarView {
    
    let titleLabel = UILabel(text: "Similar Shows", font: UIFont.boldSystemFont(ofSize: 18), textAlignment: .left)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints() {
        super.setupCollectionViewConstraints()
        addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            
            collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8)
        ])
    }
}

