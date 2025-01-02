//
//  CastCell.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 9.10.2024.
//

import UIKit
import Kingfisher

final class CastCell: UICollectionViewCell {
    let castRealName = UILabel(
        font: .boldSystemFont(ofSize: 14),
        textAlignment: .center
    )
    let castMovieName = UILabel(
        textColor: .secondaryLabel,
        font: UIFont.systemFont(ofSize: 12),
        textAlignment: .center
    )
    let posterImageView = PosterImageView(isRound: true)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraint()
        configureViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        posterImageView.kf.cancelDownloadTask()
        posterImageView.image = nil
    }
    
    func configure(_ model: Cast) {
        if let imageURL = model.imageURL {
            posterImageView.kf.setImage(with: imageURL)
        } else {
            posterImageView.image = UIImage(named: "Placeholders/no-photo")
        }
        castRealName.text = model.realName
        castMovieName.text = model.characterName
    }
}
