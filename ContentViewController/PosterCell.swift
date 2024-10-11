//
//  PosterCell.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 17.09.2024.
//

import UIKit
import Kingfisher

class PosterCell: UICollectionViewCell {
    
    static let reuseID = "PosterCell"
    let posterImageView = PosterImageView(frame: .zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(model: ContentResult) {
        posterImageView.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/w500/\(model.posterPath)"))
    }
    
    func configureSimilar(model: SimilarResult) {
        posterImageView.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/w500/\(model.posterPath)"))
    }
    

    private func setupConstraint() {
        contentView.addSubview(posterImageView)
        posterImageView.contentMode = .scaleAspectFill
        
        NSLayoutConstraint.activate([
            posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            posterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            posterImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            posterImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
