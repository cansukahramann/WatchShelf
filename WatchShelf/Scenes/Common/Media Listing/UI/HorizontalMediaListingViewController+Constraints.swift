//
//  HorizontalMediaListingViewController+Constraints.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 3.01.2025.
//

import UIKit

extension HorizontalMediaListingViewController {
    func setupConstraints() {
        view.addSubviews(collectionView, categoryNameLabel)
        
        NSLayoutConstraint.activate([
            categoryNameLabel.topAnchor.constraint(equalTo: view.topAnchor),
            categoryNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            categoryNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            
            collectionView.topAnchor.constraint(equalTo: categoryNameLabel.bottomAnchor, constant: 10),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 250)
        ])
    }
}
