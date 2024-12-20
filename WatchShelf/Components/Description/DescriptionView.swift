//
//  DescriptionView.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 3.10.2024.
//

import UIKit

final class DescriptionView: UIView {
    let label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 18)
        label.textAlignment = .natural
        label.textColor = .white.withAlphaComponent(0.7)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let button: UIButton = {
        let button = UIButton()
        button.setTitle("Read More", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var isExpanded = false
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupDescriptionLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupDescriptionLabel() {
        addSubviews(label, button)
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            
            button.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 8),
            button.trailingAnchor.constraint(equalTo: label.trailingAnchor),
            button.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }
    
    func configure(text: String) {
        label.text = text
        if text.isEmpty {
            button.isHidden = true 
        } else {
            button.isHidden = false
        }
    }
    
    @objc
    func didTapButton() {
        isExpanded.toggle()
        if isExpanded {
            label.numberOfLines = 0
            button.setTitle("Read Less", for: .normal)
        } else {
            label.numberOfLines = 2
            button.setTitle("Read More", for: .normal)
        }
    }
    
}
