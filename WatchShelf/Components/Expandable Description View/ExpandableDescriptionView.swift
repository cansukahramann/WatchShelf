//
//  DescriptionView.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 3.10.2024.
//

import UIKit

final class ExpandableDescriptionView: UIStackView {
    private let label = UILabel(
        textColor: .secondaryLabel,
        font: UIFont.systemFont(ofSize: 16),
        numberOfLines: 2
    )
    
    private let button: UIButton = {
        let button = UIButton()
        button.setTitle("Read More", for: .normal)
        button.setTitleColor(.label , for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .bold)
        button.translatesAutoresizingMaskIntoConstraints = false 
        return button
    }()
    
    private var isExpanded = false
    
    convenience init() {
        self.init(frame: .zero)
        configureViews()
    }
    
    private func configureViews() {
        axis = .vertical
        alignment = .trailing
        isLayoutMarginsRelativeArrangement = true
        layoutMargins = UIEdgeInsets(top: .zero, left: 12, bottom: .zero, right: 12)
        
        addArrangedSubviews(label, button)
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12)
        ])
    }
    
    func configure(text: String) {
        label.text = text
        let font = UIFont.systemFont(ofSize: 16)
        
        button.isHidden = label.requiredNumberOfLines() <= 2
        isHidden = text.isEmpty
    }
    
    @objc private func didTapButton() {
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
