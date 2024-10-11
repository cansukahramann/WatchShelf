//
//  DescriptionView.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 3.10.2024.
//

import UIKit

class DescriptionView: UIView {
    
    //    private let button: UIButton = {
    //        let button = UIButton()
    //
    //
    //        return button
    //    }()
    
    let label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.textAlignment = .justified
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupDescriptionLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupDescriptionLabel() {
        addSubview(label)
        label.text = "Shrek, animated cartoon character, a towering, green ogre whose fearsome appearance belies a kind heart. Shrek is the star of a highly successful series of animated films. At the beginning of the 2001 film Shrek, the title character lives as a recluse in a remote swamp in the fairy-tale land of Duloc."
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor,constant: 28),
            label.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 12),
            label.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -12),
            label.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func configure(text: String) {
        label.text = text
    }
    
}
