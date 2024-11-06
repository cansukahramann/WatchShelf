//
//  SearchCell.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 4.11.2024.
//

import UIKit
import Kingfisher

class SearchCell: UITableViewCell {
    
    private let posterImageView  = PosterImageView(frame: .zero,isRound: false)
    private let nameLabel = EventLabel(textAlignment: .left, fontSize: 24)
    private let dateLabel = EventLabel(textAlignment: .left, fontSize: 12)
    
    private let mediaType: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .systemBlue
        imageView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = .red
        return imageView
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
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
        contentView.addSubview(posterImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(dateLabel)
        stackView.addArrangedSubview(mediaType)
        
        
        
        NSLayoutConstraint.activate([
            posterImageView.heightAnchor.constraint(equalToConstant: 100),
            posterImageView.widthAnchor.constraint(equalToConstant: 80),
            posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 8),
            posterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            posterImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor,constant: 4),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            nameLabel.bottomAnchor.constraint(equalTo: stackView.topAnchor,constant: -8),
            
            stackView.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor,constant: 4),
            stackView.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor)
        ])
    }
    
    func configure(result: SearchResponseModel.Result, displayName: String) {
        if let poster_path = result.poster_path {
            posterImageView.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/w500\(poster_path)"))
        } else {
            posterImageView.image = UIImage(named: "default-poster")
        }
        
        nameLabel.text = displayName
        dateLabel.text = result.release_date?.isEmpty == false ? result.release_date : "-"
        mediaType.image = result.media_type == .movie ? Image.movieTypeSymbol : Image.tvTypeSymbol
    }
    
    func config(model: StoreableMedia) {
        if let posterPath = model.posterPath{
            posterImageView.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)"))
        } else {
            posterImageView.image = UIImage(named: "default-poster")
        }
        nameLabel.text = model.title
        dateLabel.text = model.release_date
    }
}
