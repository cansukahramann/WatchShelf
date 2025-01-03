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

final class SimilarMoviesView: UIView, SimilarMovieViewModelDelegate {
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemBackground
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    let titleLabel = UILabel(text: "Similar Movies", font: UIFont.boldSystemFont(ofSize: 18), textAlignment: .left)
    private var viewModel: SimilarMovieViewModel!
    weak var delegate: SimilarMoviesViewDelegate!
    var didSelectItem: ((_ id: Int) -> Void)?
    
    convenience init(viewModel: SimilarMovieViewModel) {
        self.init(frame: .zero)
        self.viewModel = viewModel
        viewModel.delegate = self
        configureUI()
        setupConstraints()
        viewModel.fetchSimilarModel()
    }
    
    func configureUI() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(PosterCell.self)
        collectionView.register(IndicatorCell.self)
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

extension SimilarMoviesView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.similarModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item != viewModel.similarModel.count {
            let cell = collectionView.dequeueCell(PosterCell.self, for: indexPath)
            cell.configure(posterPath: viewModel.similarModel[indexPath.item].posterPath)
            return cell
        } else {
            let cell = collectionView.dequeueCell(IndicatorCell.self, for: indexPath)
            cell.indicator.startAnimating()
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedSimilarMovieID = viewModel.similarModel[indexPath.item].id
        delegate?.similarMovieSelected(movieID: selectedSimilarMovieID)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if (indexPath.row == viewModel.similarModel.count ) && !viewModel.isFetchingContent && viewModel.shouldRequestNextPage{
            _ = (Int(viewModel.similarModel.count) / 20) + 1
            viewModel.fetchSimilarModel()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.frame.size
        let cellHeight =  (indexPath.item == viewModel.similarModel.count && viewModel.isFetchingContent ) ? 40  : (size.height)
        return CGSize(width: 190, height: cellHeight)
    }
}

extension SimilarMoviesView: UICollectionViewDelegateFlowLayout {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let offsetX = scrollView.contentOffset.x
        let contentWidth = scrollView.contentSize.height
        let width = scrollView.frame.size.width
        
        if offsetX >= contentWidth - (2 * width) {
            viewModel.fetchSimilarModel()
            self.updateCollectionView()
        }
    }
}
