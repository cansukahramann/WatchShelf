//
//  WatchListViewController+Constraints.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 3.01.2025.
//

import UIKit

extension WatchListViewController {
    func setupConstraints() {
        view.addSubviews(tableView, emptyStateAnimationView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            emptyStateAnimationView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emptyStateAnimationView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            emptyStateAnimationView.widthAnchor.constraint(equalToConstant: 300),
            emptyStateAnimationView.heightAnchor.constraint(equalToConstant: 300)
        ])
    }
}
