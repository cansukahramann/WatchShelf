//
//  CategoryDetailViewController+Constraints.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 3.01.2025.
//

import UIKit

extension CategoryDetailViewController {
    func setupConstraints() {
        view.addSubviews(collectionView, noContentLabel)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            noContentLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            noContentLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            noContentLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            noContentLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}
