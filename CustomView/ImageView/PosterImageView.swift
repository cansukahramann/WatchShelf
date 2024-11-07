//
//  PosterImageView.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 19.09.2024.
//

import UIKit


class PosterImageView: UIImageView {
    
    private var isRound: Bool
    
    init(frame: CGRect, isRound: Bool = false) {
        
        self.isRound = isRound
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        contentMode = .scaleAspectFit
    }
    
    required init?(coder: NSCoder) {
        self.isRound = false
        super.init(coder: coder)
        translatesAutoresizingMaskIntoConstraints = false
        contentMode = .scaleAspectFit
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if isRound {
            layer.cornerRadius = min(bounds.size.width, bounds.size.height) / 2
        } else {
            layer.cornerRadius = 12
        }
        clipsToBounds = true
    }

}
