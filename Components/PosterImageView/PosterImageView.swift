//
//  PosterImageView.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 19.09.2024.
//

import UIKit

final class PosterImageView: UIImageView {
    private var isCircle: Bool
    
    init(isRound: Bool = false) {
        self.isCircle = isRound
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        contentMode = .scaleAspectFill
    }
    
    required init?(coder: NSCoder) {
        self.isCircle = false
        super.init(coder: coder)
        translatesAutoresizingMaskIntoConstraints = false
        contentMode = .scaleAspectFill
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if isCircle {
            layer.cornerRadius = min(bounds.size.width, bounds.size.height) / 2
        } else {
            layer.cornerRadius = 12
        }
        clipsToBounds = true
    }

}
