//
//  DetailHeaderView.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 23.09.2024.
//

import UIKit
import Kingfisher

class DetailHeaderView: UIView {
    
    private let posterImageView = PosterImageView(frame: .zero, isRound: false)
    private let titleLabel = EventLabel(textAlignment: .left, fontSize: 26)
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 12
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createAttributeView(image: UIImage, text: String) -> AttributeView {
        let attributeView = AttributeView()
        attributeView.translatesAutoresizingMaskIntoConstraints = false
        attributeView.attributeImage.image = image
        attributeView.attributeLabel.text = text
        return attributeView
    }
    
    private func setupView() {
        addSubview(titleLabel)
        addSubview(posterImageView)
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -4),
            titleLabel.bottomAnchor.constraint(equalTo: stackView.topAnchor,constant: -12),
            
            posterImageView.topAnchor.constraint(equalTo: topAnchor),
            posterImageView.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 12),
            posterImageView.widthAnchor.constraint(equalToConstant: 192),
            posterImageView.heightAnchor.constraint(equalToConstant: 240),
            posterImageView.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: 0),
            
            stackView.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor)
        ])
        
    }
    
    
    func configure(model: DetailModel) {
        titleLabel.text = model.title
        if let posterPath = model.posterPath {
            posterImageView.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/w500/\(posterPath)"))
        } else {
            posterImageView.image = UIImage(named: "default-poster")
        }
        
        let genreString = model.genres.map { $0.name }.joined(separator: ", ")
        
        let attributes = [
            (Image.dateSymbol, "\(model.releaseDate)"),
            (Image.genreSymbol, "\(genreString)"),
            (Image.runtimeSymbol, "\(model.runtime) min"),
            (Image.ratingSymbol, "\(model.voteAverage)")
        ]
        
        for (image, text) in attributes {
            let attributeView = createAttributeView(image: image!, text: text)
            stackView.addArrangedSubview(attributeView)
        }
    }
    
    func configureCastDetail(model: CastDetailModel) {
        titleLabel.text = model.name
        if let profilePath = model.profilePath {
            posterImageView.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/w500\(profilePath)"))
        } else {
            posterImageView.image = UIImage(named: "no-photo")
        }
        
        let placeOfBirth = model.placeOfBirthday ?? "N/A"
        let birthday = model.birthday ?? "N/A"
        
        let attributes = [
            (Image.locationSymbol, placeOfBirth),
            (Image.dateSymbol, birthday)
        ]
        
        for (image, text) in attributes {
            let attributeView = createAttributeView(image: image!, text: text)
            stackView.addArrangedSubview(attributeView)
        }
    }
    
    func configureTVDetail(model: TVShowDetailModel) {
        titleLabel.text = model.name
        if let posterPath = model.posterPath {
            posterImageView.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)"))
        } else {
            posterImageView.image = UIImage(named: "no-photo")
        }
        
        
        let genresString = model.genres.map { $0.name }.joined(separator: ", ")
        
        let attributes = [
            (Image.dateSymbol, "\(model.firstAirDate ?? "") - \(model.lastAirDate ?? "")"),
            (Image.genreSymbol, "\(genresString)"),
            (Image.runtimeSymbol, "\(model.numberOfSeasons) "),
            (Image.infoSymbol, "\(model.status)"),
            (Image.ratingSymbol, "\(model.voteAverage)")
        ]
        
        for (image, text) in attributes {
            let attributeView = createAttributeView(image: image!, text: text)
            stackView.addArrangedSubview(attributeView)
        }
    }
}
