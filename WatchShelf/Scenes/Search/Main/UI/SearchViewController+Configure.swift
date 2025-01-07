//
//  SearchViewController+Configure.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 7.01.2025.
//

import UIKit

extension SearchViewController {
    func configureNoResultsLabel() {
        view.addSubview(label)
        label.isHidden = true
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
}
