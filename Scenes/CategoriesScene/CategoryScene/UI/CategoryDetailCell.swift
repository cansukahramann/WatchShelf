//
//  CategoryDetailCell.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 8.11.2024.
//

import UIKit
import Kingfisher

class CategoryDetailCell: UICollectionViewCell {
    
    let posterImage = PosterImageView(frame: .zero, isRound: false)
    static let reuseID = "CategoryDetailCell"
    
    let shapeLayer = CAShapeLayer()
    let trackLayer = CAShapeLayer()
    
    let percentagLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
   
    let iconImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.tintColor = .white
        image.backgroundColor = .black
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        
    }
    
    func configureRatingCircle(rating: Double) {
        let radius: CGFloat = 20
        let offset: CGFloat = 10
        
        let center = CGPoint(x: radius + offset, y: contentView.bounds.height - radius - offset)
        
        let circularPath = UIBezierPath(arcCenter: center, radius: radius, startAngle: -CGFloat.pi / 2, endAngle: 3 * CGFloat.pi / 2, clockwise: true)
        
        trackLayer.path = circularPath.cgPath
        trackLayer.strokeColor = UIColor.lightGray.cgColor
        trackLayer.lineWidth = 5
        trackLayer.fillColor = UIColor.black.cgColor
        trackLayer.lineCap = .round
        trackLayer.shadowColor = UIColor.black.cgColor
        trackLayer.shadowOpacity = 0.7
        trackLayer.shadowOffset = CGSize(width: 4, height: 4)
        trackLayer.shadowRadius = 6
        contentView.layer.addSublayer(trackLayer)
        
        shapeLayer.path = circularPath.cgPath
        shapeLayer.strokeColor = UIColor(named: "app_color")?.cgColor
        shapeLayer.lineCap = .round
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineWidth = 5
        shapeLayer.strokeEnd = 0
        shapeLayer.shadowColor = UIColor.purple.cgColor
        shapeLayer.shadowOpacity = 0.7
        shapeLayer.shadowOffset = CGSize(width: 4, height: 4)
        shapeLayer.shadowRadius = 6
        contentView.layer.addSublayer(shapeLayer)
        contentView.addSubview(percentagLabel)
        NSLayoutConstraint.activate([
            percentagLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor,constant: center.x - contentView.bounds.width / 2),
            percentagLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor,constant: center.y - contentView.bounds.height / 2),
            percentagLabel.widthAnchor.constraint(equalToConstant: 60),
            percentagLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        animateCircle(for: rating)
    }
    
    private func animateCircle(for rating: Double) {
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        let normalizedRating = min(CGFloat(rating / 10), 1.0)
        basicAnimation.toValue = normalizedRating
        basicAnimation.duration = 1.0
        basicAnimation.fillMode = .forwards
        basicAnimation.isRemovedOnCompletion = false
        shapeLayer.add(basicAnimation, forKey: "rate")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubviews(posterImage,iconImageView)
        posterImage.translatesAutoresizingMaskIntoConstraints = false
  
        NSLayoutConstraint.activate([
            posterImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            posterImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            posterImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            posterImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            iconImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            iconImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            iconImageView.widthAnchor.constraint(equalToConstant: 24),
            iconImageView.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
    
    func configure(model: DiscoverResult) {
        if let posterPath = model.posterPath {
            posterImage.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)"))
        } else {
            posterImage.image = UIImage(named: "default-poster")
        }
        percentagLabel.text = String(format: "%.1f", model.voteAverage ?? 0.0)
        
        if model.isMovie {
            iconImageView.image = Image.movieTypeSymbol
        } else if model.isTVShow {
            iconImageView.image = Image.tvTypeSymbol
        }
    }
}
