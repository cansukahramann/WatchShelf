//
//  SearchCell.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 4.11.2024.
//

import UIKit
import Kingfisher

final class SearchCell: UITableViewCell {
    private let posterImageView  = PosterImageView(isRound: false)
    private let nameLabel = Label(font: UIFont.boldSystemFont(ofSize: 20), textAlignment: .left)
    private let dateLabel = Label(font: UIFont.systemFont(ofSize: 18), textAlignment: .left)
    
    private let mediaType: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .systemBlue
        imageView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = UIColor.accent
        return imageView
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 12
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier:  reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubviews(posterImageView, nameLabel, stackView)
        stackView.addArrangedSubviews(dateLabel, mediaType)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false 
        
        NSLayoutConstraint.activate([
            posterImageView.heightAnchor.constraint(equalToConstant: 100),
            posterImageView.widthAnchor.constraint(equalToConstant: 80),
            posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 8),
            posterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            posterImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 4),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            nameLabel.bottomAnchor.constraint(equalTo: stackView.topAnchor, constant: -12),
            
            stackView.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 4),
            stackView.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor)
        ])
    }
    
    func configure(result: SearchResponseModel.Result, displayName: String) {
        if let poster_path = result.posterPath {
            posterImageView.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/w500\(poster_path)"))
        } else {
            posterImageView.image = UIImage(named: "Placeholders/default-poster")
        }
        
        nameLabel.text = displayName
        dateLabel.text = result.releaseDate?.isEmpty == false ? result.releaseDate : "-"
        mediaType.image = result.mediaType == .movie ? Image.movieTypeSymbol : Image.tvTypeSymbol
    }
    
    func config(model: StoreableMedia) {
        if let posterPath = model.posterPath{
            posterImageView.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)"))
        } else {
            posterImageView.image = UIImage(named: "Placeholders/default-poster")
        }
        nameLabel.text = model.title
        dateLabel.text = model.release_date
    }
}
