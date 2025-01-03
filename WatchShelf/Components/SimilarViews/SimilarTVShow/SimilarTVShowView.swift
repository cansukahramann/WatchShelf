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

final class SimilarTVShowView: UIView, SimilarTVShowViewModelDelegate {
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemBackground
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    let titleLabel = UILabel(text: "Similar Shows", font: UIFont.boldSystemFont(ofSize: 18), textAlignment: .left)
    private var viewModel: SimilarTVShowViewModel!
    weak var delegate: SimilarTVShowViewDelegate?
    var didSelectItem: ((_ id: Int) -> Void)? 
    
    convenience init(viewModel: SimilarTVShowViewModel) {
        self.init(frame: .zero)
        self.viewModel = viewModel
        viewModel.fetchTVShowSimilarModel()
        viewModel.delegate = self
        configureUI()
        setupConstraints()
    }
    
    func configureUI() {
        collectionView.register(PosterCell.self)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    func updateCollectionView() {
        collectionView.reloadData()
    }
    
    func hiddenIfNoData() {
        self.isHidden = viewModel.similarModel.isEmpty
    }
}

extension SimilarTVShowView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.similarModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(PosterCell.self, for: indexPath)
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

