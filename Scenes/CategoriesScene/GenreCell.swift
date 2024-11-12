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
        applyGradient()
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func applyGradient() {
        gradientLayer = CAGradientLayer()
        gradientLayer?.colors = [UIColor.black.cgColor, UIColor.black.cgColor]
        gradientLayer?.startPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer?.endPoint = CGPoint(x: 0.5, y: 1)
        gradientLayer?.locations = [0.0, 1.0]
        gradientLayer?.frame = contentView.bounds
        contentView.layer.insertSublayer(gradientLayer!, at: 0)
        
        let borderLayer = CALayer()
        borderLayer.frame = contentView.bounds
        borderLayer.borderColor = UIColor.white.cgColor
        borderLayer.borderWidth = 4.0
        borderLayer.cornerRadius = 12.0
        borderLayer.opacity = 0.5

        borderLayer.shadowColor = UIColor.white.cgColor
        borderLayer.shadowOpacity = 0.9
        borderLayer.shadowOffset = CGSize(width: 8, height: 8)
        borderLayer.shadowRadius = 10.0

        contentView.layer.addSublayer(borderLayer)
        
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
        layer.cornerRadius = 15
        layer.masksToBounds = true
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
