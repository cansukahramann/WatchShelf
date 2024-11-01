//
//  SimilarMoviesView.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 8.10.2024.
//

import UIKit

protocol SimilarMoviesViewDelegate: AnyObject {
    func similarMovieSelected(movieID: Int)
}

class SimilarMoviesView: UIView {

    private var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemBackground
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    let titleLabel = EventLabel(textAlignment: .left, fontSize: 18)
    private var model =  [SimilarResult]()
    weak var delegate: SimilarMoviesViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCollectionView()
        
        titleLabel.text = "Similar Movies"

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCollectionView() {
        addSubview(titleLabel)
        addSubview(collectionView)
        
        collectionView.register(PosterCell.self, forCellWithReuseIdentifier: PosterCell.reuseID)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -12),
            
            
            collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,constant: 8),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 12),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor,constant: -12),
            collectionView.heightAnchor.constraint(equalToConstant: 250)
        ])
    }

    func updateSimilarMovie(model: [SimilarResult]) {
        self.model = model
        collectionView.reloadData()
    }
}

extension SimilarMoviesView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        model.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PosterCell.reuseID, for: indexPath) as! PosterCell
        cell.configureSimilar(model: model[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedSimilarMovieID = model[indexPath.item].id
        delegate?.similarMovieSelected(movieID: selectedSimilarMovieID)
    }
}

extension SimilarMoviesView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 190, height: collectionView.bounds.height)
    }
}
