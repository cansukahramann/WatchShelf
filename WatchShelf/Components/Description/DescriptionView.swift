//
//  DescriptionView.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 3.10.2024.
//

import UIKit

final class DescriptionView: UIView { 
    private let label = UILabel(textColor: .secondaryLabel, font: UIFont.systemFont(ofSize: 17), numberOfLines: 2)
    
    private let button: UIButton = {
        let button = UIButton()
        button.setTitle("Read More", for: .normal)
        button.setTitleColor(.label , for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .bold)
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
            
            button.topAnchor.constraint(equalTo: label.bottomAnchor),
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
