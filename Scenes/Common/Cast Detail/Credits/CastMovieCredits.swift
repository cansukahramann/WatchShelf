//
//  CastMovieCredits.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 25.10.2024.
//

import UIKit

protocol CastMovieCreditsDelegate: AnyObject {
    func movieCreditsSelected(movieID: Int)
}

final class CastMovieCredits: UIView {
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemBackground
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false 
        return collectionView
    }()
    
    weak var delegate: CastMovieCreditsDelegate?
    private let titleLabel = Label(font: UIFont.boldSystemFont(ofSize: 18), textAlignment: .left)
    private var model = [CastCredit]()

    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupCollectionView()
        setupUI()
        titleLabel.text = "Movies"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCollectionView() {
        collectionView.register(PosterCell.self, forCellWithReuseIdentifier: PosterCell.reuseID)
        collectionView.dataSource = self
        collectionView.delegate = self 
    }
    
    func setupUI() {
        addSubviews(titleLabel,collectionView)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false 
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            
            collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 12),
            collectionView.heightAnchor.constraint(equalToConstant: 250)
        ])
    }
    
    func updateCreditsMovie(model: [CastCredit]) {
        self.model = model
        collectionView.reloadData()
    }
}

extension CastMovieCredits: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        model.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PosterCell.reuseID, for: indexPath) as! PosterCell
        cell.configure(posterPath: model[indexPath.item].posterPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedItemID = model[indexPath.item].id
        delegate?.movieCreditsSelected(movieID: selectedItemID)
    }
}

extension CastMovieCredits: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 190, height: collectionView.bounds.height)
    }
}
