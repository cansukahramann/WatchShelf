//
//  VideoView+Constraints.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 3.01.2025.
//

import UIKit

extension VideoView {
    func setupVideoView() {
        addSubview(webView)
        
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: topAnchor),
            webView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            webView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            webView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
