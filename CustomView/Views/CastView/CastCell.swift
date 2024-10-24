//
//  CastCell.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 9.10.2024.
//

import UIKit
import Kingfisher

class CastCell: UICollectionViewCell {
    
    static let reuseID = "CastCell"
    var castRealName = NameLabel(textColor: .white, fontSize: 16)
    var castMovieName = NameLabel(textColor: .white.withAlphaComponent(0.7), fontSize: 12)
    var posterImageView = PosterImageView(frame: .zero)
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraint()
        
        posterImageView.contentMode = .scaleAspectFill
        
        castRealName.setContentCompressionResistancePriority(.required, for: .vertical)
        castMovieName.setContentCompressionResistancePriority(.required, for: .vertical)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        posterImageView.kf.cancelDownloadTask()
        posterImageView.image = nil
    }
    
    private func setupConstraint() {
        contentView.addSubview(posterImageView)
        contentView.addSubview(castRealName)
        contentView.addSubview(castMovieName)
        posterImageView.contentMode = .scaleAspectFill
        
        NSLayoutConstraint.activate( [
            posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 8),
            posterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            posterImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            castRealName.topAnchor.constraint(equalTo: posterImageView.bottomAnchor,constant: 2),
            castRealName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            castRealName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            castMovieName.topAnchor.constraint(equalTo: castRealName.bottomAnchor,constant: 2),
            castMovieName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            castMovieName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            castMovieName.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
            
        ])
    }
    
    func configure(model: Cast) {
        if let profilePath = model.profilePath {
            posterImageView.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/w500\(profilePath)"))
        } else {
            posterImageView.image = UIImage(named: "no-photo")
        }
        
        castRealName.text = model.name
        castMovieName.text = model.character
    }
}
