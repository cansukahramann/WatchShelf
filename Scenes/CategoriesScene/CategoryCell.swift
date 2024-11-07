//
//  CategoryCell.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 7.11.2024.
//

import UIKit


final class CategoryCell: UICollectionViewCell {
    
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
    
    let darkRed = UIColor(red: 0.8, green: 0.1, blue: 0.1, alpha: 0.5)
    let lightRed = UIColor(red: 1.0, green: 0.5, blue: 0.4, alpha: 0.5)
    
    private func applyGradient() {
        gradientLayer = CAGradientLayer()
        gradientLayer?.colors = [darkRed.cgColor, lightRed.cgColor]
        gradientLayer?.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer?.endPoint = CGPoint(x: 0, y: 1)
        gradientLayer?.frame = contentView.bounds
        if let gradientLayer = gradientLayer {
            contentView.layer.insertSublayer(gradientLayer, at: 0)
        }
        
    }
    
    func animateCellTap(animationCompletion: @escaping () -> Void) {
        UIView.animate(withDuration: 0.2) { [self] in
            transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        } completion: { [self] _ in
            UIView.animate(withDuration: 0.2) { [self] in
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
    
    func configure() {
        categoryName.text = "Romance"
    }
    
}
