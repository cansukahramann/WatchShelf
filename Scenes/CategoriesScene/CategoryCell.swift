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
    
    let color1 = UIColor(red: 94/255, green: 62/255, blue: 143/255, alpha: 1.0)
    let color2 = UIColor(red: 122/255, green: 82/255, blue: 168/255, alpha: 1.0)
    let color3 = UIColor(red: 153/255, green: 101/255, blue: 199/255, alpha: 1.0)

    private func applyGradient() {
        gradientLayer = CAGradientLayer()
        gradientLayer?.colors =  [color1.cgColor, color2.cgColor, color3.cgColor]
        gradientLayer?.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer?.endPoint = CGPoint(x: 0, y: 1)
        gradientLayer?.frame = contentView.bounds
        if let gradientLayer = gradientLayer {
            contentView.layer.insertSublayer(gradientLayer, at: 0)
        }
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
