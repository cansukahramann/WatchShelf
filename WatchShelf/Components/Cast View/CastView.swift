//
//  CastView.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 2.01.2025.
//

import UIKit

final class CastView: UIView {
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemBackground
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    let titleLabel = UILabel(text:"Top Billed Cast", font: UIFont.boldSystemFont(ofSize: 18), textAlignment: .left)
    
    var casts = [Cast]() {
        didSet { collectionView.reloadData() }
    }
    
    var onCastSelection: ((_ id: Int) -> Void)?
    
    convenience init() {
        self.init(frame: .zero)
        collectionView.register(CastCell.self)
        collectionView.dataSource = self
        collectionView.delegate = self
        setupConstraints()
    }
}

extension CastView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return casts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(CastCell.self, for: indexPath)
        let model = casts[indexPath.item]
        cell.configure(model)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedCastID = casts[indexPath.item].id
        onCastSelection?(selectedCastID)
    }
}

extension CastView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: collectionView.bounds.height)
    }
}
