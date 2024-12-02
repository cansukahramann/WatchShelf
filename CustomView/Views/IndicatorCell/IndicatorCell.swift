//
//  IndicatorCell.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 2.12.2024.
//

import UIKit

class IndicatorCell: UICollectionViewCell {
    
    static let reuseID = "IndicatorCell"
    
    var indicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.style = .medium
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup() {
        contentView.addSubview(indicator)
        NSLayoutConstraint.activate([
            indicator.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            indicator.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
        indicator.startAnimating()
    }
}
