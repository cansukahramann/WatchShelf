//
//  MovieCastView.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 9.10.2024.
//

import UIKit

protocol CastViewDelegate: AnyObject {
    func movieCastSelected(castID: Int)
}

final class MovieCastView: UIView {
    private var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemBackground
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private let titleLabel = Label(font: UIFont.boldSystemFont(ofSize: 18), textAlignment: .left)
    var model = [Cast]()
    weak var delegate: CastViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        titleLabel.text = "Top Billed Cast"
        collectionView.register(CastCell.self)
        collectionView.dataSource = self
        collectionView.delegate = self
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints() {
        addSubviews(titleLabel, collectionView)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            
            collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 200),
        ])
    }
    
    func updateCastView(model: [Cast]) {
        self.model = model
        collectionView.reloadData()
    }
}

extension MovieCastView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(CastCell.self, for: indexPath)
        cell.configureMovieCast(model: model[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedCastID = model[indexPath.item].id
        delegate?.movieCastSelected(castID: selectedCastID)
    }
}

extension MovieCastView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: collectionView.bounds.height)
    }
}
