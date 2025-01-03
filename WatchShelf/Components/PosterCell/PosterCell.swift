//
//  PosterCell.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 17.09.2024.
//

import UIKit
import Kingfisher

class PosterCell: UICollectionViewCell {
    let posterImageView = PosterImageView(isRound: false)
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        posterImageView.contentMode = .scaleAspectFill
        setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        posterImageView.kf.cancelDownloadTask()
        posterImageView.image = nil
    }
    
    func configure(posterPath: String?) {
        if let posterPath = posterPath {
            posterImageView.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)"))
        } else {
            posterImageView.image = UIImage(named: "Placeholders/default-poster")
        }
    }
}
