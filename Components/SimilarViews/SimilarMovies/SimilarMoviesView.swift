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
    private var viewModel: SimilarMovieViewModel!
    weak var delegate: SimilarMoviesViewDelegate!
    var didSelectItem: ((_ id: Int) -> Void)?
    
    convenience init(viewModel: SimilarMovieViewModel) {
        self.init(frame: .zero)
        self.viewModel = viewModel
        viewModel.delegate = self
        titleLabel.text = "Similar Movies"
        setupCollectionView()
        viewModel.fetchSimilarModel()
    }
    
    func setupCollectionView() {
        addSubview(titleLabel)
        addSubview(collectionView)
        
        collectionView.register(PosterCell.self, forCellWithReuseIdentifier: PosterCell.reuseID)
        collectionView.register(IndicatorCell.self, forCellWithReuseIdentifier: IndicatorCell.reuseID)
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

extension SimilarMoviesView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.similarModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item != viewModel.similarModel.count {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PosterCell.reuseID, for: indexPath) as! PosterCell
            cell.configure(posterPath: viewModel.similarModel[indexPath.item].posterPath)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: IndicatorCell.reuseID, for: indexPath) as! IndicatorCell
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
        return CGSize(width: 190 , height: cellHeight)
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
