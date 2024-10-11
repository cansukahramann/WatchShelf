//
//  CastView.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 9.10.2024.
//

import UIKit

class CastView: UIView {
    
    private var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemBackground
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private let titleLabel = EventLabel(textAlignment: .left, fontSize: 18)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        titleLabel.text = "Top Billed Cast"
        collectionView.register(CastCell.self, forCellWithReuseIdentifier: CastCell.reuseID)
        collectionView.dataSource = self
        collectionView.delegate = self
        setupConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints() {
        addSubview(titleLabel)
        addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor,constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            
            collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 240),
        ])
    }
}

extension CastView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CastCell.reuseID, for: indexPath) as! CastCell
        cell.posterImageView.image = UIImage(named: "shrek-cast")
        cell.posterImageView.backgroundColor = .blue
        cell.castMovieName.text = "Shrek"
        cell.castRealName.text = "Shrek"
        return cell
    }
}

extension CastView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: collectionView.bounds.height)
    }
}
