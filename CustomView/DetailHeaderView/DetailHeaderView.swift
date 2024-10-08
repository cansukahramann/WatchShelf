//
//  DetailHeaderView.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 23.09.2024.
//

import UIKit

class DetailHeaderView: UIView {
    
    let posterImageView = PosterImageView(frame: .zero)
    let titleLabel = EventLabel(textAlignment: .left, fontSize: 26)
    
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
        attributeView.attributeImage.image = image
        attributeView.attributeLabel.text = text
        return attributeView
    }
    
    private func setupView() {
        addSubview(titleLabel)
        addSubview(posterImageView)
        addSubview(stackView)
        posterImageView.image = .shrekPoster
        titleLabel.text = "sadasdasd"
        titleLabel.textColor = .red
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -4),
            titleLabel.bottomAnchor.constraint(equalTo: stackView.topAnchor,constant: -12),
            
            posterImageView.topAnchor.constraint(equalTo: topAnchor),
            posterImageView.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 12),
            posterImageView.widthAnchor.constraint(equalToConstant: 160),
            posterImageView.heightAnchor.constraint(equalToConstant: 180),
            
            stackView.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        let attributes = [
            (Image.dateSymbol, "2024"),
            (Image.genreSymbol, "Drama"),
            (Image.runtimeSymbol, "2h 30m"),
            (Image.ratingSymbol, "8.5/10")
        ]
        
        for (image, text) in attributes {
            let attributeView = createAttributeView(image: image!, text: text)
            stackView.addArrangedSubview(attributeView)
        }
    }
    
}
