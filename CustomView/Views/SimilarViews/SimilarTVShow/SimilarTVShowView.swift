//
//  SimilarTVShowView.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 26.10.2024.
//

import UIKit

protocol SimilarTVShowViewDelegate: AnyObject {
    func similarTVShowSelected(tvShowID: Int)
}

class SimilarTVShowView: UIView,SimilarTVShowViewModelDelegate {
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
    private var viewModel: SimilarTVShowViewModel!
    weak var delegate: SimilarTVShowViewDelegate?
    var didSelectItem: ((_ id: Int) -> Void)? 
    
    convenience init(viewModel: SimilarTVShowViewModel) {
        self.init(frame: .zero)
        self.viewModel = viewModel
        viewModel.fetchTVShowSimilarModel()
        viewModel.delegate = self
        setupCollectionView()
        titleLabel.text = "Similar Shows"
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
    func updateCollectionView() {
        collectionView.reloadData()
    }
}

extension SimilarTVShowView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.similarModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PosterCell.reuseID, for: indexPath) as! PosterCell
        cell.configure(posterPath: viewModel.similarModel[indexPath.item].posterPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedSimilarMovieID = viewModel.similarModel[indexPath.item].id
        delegate?.similarTVShowSelected(tvShowID: selectedSimilarMovieID)
    }
}

extension SimilarTVShowView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 190, height: collectionView.bounds.height)
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let offsetX = scrollView.contentOffset.x
        let contentWidth = scrollView.contentSize.height
        let width = scrollView.frame.size.width
        
        if offsetX >= contentWidth - (2 * width) {
            viewModel.fetchTVShowSimilarModel()
            self.updateCollectionView()
        }
    }
}

