//
//  DetailHeaderView.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 23.09.2024.
//

import UIKit
import Kingfisher

final class DetailHeaderView: UIView {
    let posterImageView = PosterImageView(isRound: false)
    let titleLabel = UILabel(font: UIFont.boldSystemFont(ofSize: 20), numberOfLines: 0, textAlignment: .left)
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 12
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupConstraints()
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
    
    func configure(model: MovieDetailModel) {
        titleLabel.text = model.title
        if let posterPath = model.posterPath {
            posterImageView.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/w500/\(posterPath)"))
        } else {
            posterImageView.image = UIImage(named: "Placeholders/default-poster")
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
    
    func configureCastDetail(model: CastDetailResponse) {
        titleLabel.text = model.name
        if let profilePath = model.profilePath {
            posterImageView.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/w500\(profilePath)"))
        } else {
            posterImageView.image = UIImage(named: "Placeholders/no-photo")
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
    
    func configureTVDetail(model: TVShowDetails) {
        titleLabel.text = model.name
        if let posterPath = model.posterPath {
            posterImageView.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)"))
        } else {
            posterImageView.image = UIImage(named: "Placeholders/no-photo")
        }
        
        let genresString = model.genres.map { $0.name }.joined(separator: ", ")
        
        let attributes = [
            (Image.dateSymbol, "\(model.firstAirDate ?? "") - \(model.lastAirDate ?? "")"),
            (Image.genreSymbol, "\(genresString)"),
            (Image.runtimeSymbol, "\(model.numberOfSeasons) season"),
            (Image.infoSymbol, "\(model.status)"),
            (Image.ratingSymbol, "\(model.voteAverage)")
        ]
        
        for (image, text) in attributes {
            let attributeView = createAttributeView(image: image!, text: text)
            stackView.addArrangedSubview(attributeView)
        }
    }
}
