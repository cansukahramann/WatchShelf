//
//  GenreCell.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 7.11.2024.
//

import UIKit


final class GenreCell: UICollectionViewCell {
    
    static let reuseID = "CategoryCell"
    let categoryName = EventLabel(textAlignment: .center, fontSize: 24)
    private var gradientLayer: CAGradientLayer?
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func animateCellTap(animationCompletion: @escaping () -> Void) {
        UIView.animate(withDuration: 0.1) { [self] in
            transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        } completion: { [self] _ in
            UIView.animate(withDuration: 0.1) { [self] in
                transform = CGAffineTransform.identity
            } completion: { _ in
                animationCompletion()
            }
        }
    }
    
    private func setupUI() {
        contentView.layer.borderWidth = 4.0
        contentView.layer.borderColor = UIColor.white.cgColor
        contentView.layer.cornerRadius = 12.0
        contentView.clipsToBounds = true
        contentView.addSubview(categoryName)
        
        NSLayoutConstraint.activate([
            categoryName.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            categoryName.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
            
        ])
    }
    
    func configure(model: GenreResponse) {
        categoryName.text = model.name
    }
    
}
