//
//  BaseSimilarView.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 5.01.2025.
//

import UIKit

protocol BaseSimilarViewDelegate: AnyObject {
    func similarContentSelected(similarID: Int)
}

class BaseSimilarView: UIView, BaseSimilarViewViewModelDelegate {
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemBackground
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    let scrollView: UIScrollView = {
            let scrollView = UIScrollView()
            scrollView.translatesAutoresizingMaskIntoConstraints = false
            return scrollView
        }()

    private var viewModel: BaseSimilarViewViewModel!
    weak var delegate: BaseSimilarViewDelegate!
    var didSelectItem: ((_ id: Int) -> Void)?
    
    convenience init(viewModel: BaseSimilarViewViewModel) {
        self.init(frame: .zero)
        self.viewModel = viewModel
        viewModel.delegate = self
        configureUI()
        viewModel.fetchSimilarContent()
    }
    
    func configureUI() {
        collectionView.register(PosterCell.self)
        collectionView.register(IndicatorCell.self)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    func setupCollectionViewConstraints() {
           addSubview(collectionView)
           
           NSLayoutConstraint.activate([
               collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
               collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
               collectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12),
               collectionView.heightAnchor.constraint(equalToConstant: 250)
           ])
       }
   
    func updateCollectionView() {
        collectionView.reloadData()
    }
    
    func hiddenIfNoData() {
        self.isHidden = viewModel.similarModel.isEmpty
    }
}

extension BaseSimilarView: UICollectionViewDataSource {
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
        delegate?.similarContentSelected(similarID: selectedSimilarMovieID)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if (indexPath.row == viewModel.similarModel.count ) && !viewModel.isFetchingContent && viewModel.shouldRequestNextPage{
            _ = (Int(viewModel.similarModel.count) / 20) + 1
            viewModel.fetchSimilarContent()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.frame.size
        let cellHeight =  (indexPath.item == viewModel.similarModel.count && viewModel.isFetchingContent ) ? 40  : (size.height)
        return CGSize(width: 190, height: cellHeight)
    }
}

extension BaseSimilarView: UICollectionViewDelegateFlowLayout {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let offsetX = scrollView.contentOffset.x
        let contentWidth = scrollView.contentSize.height
        let width = scrollView.frame.size.width
        
        if offsetX >= contentWidth - (2 * width) {
            viewModel.fetchSimilarContent()
            self.updateCollectionView()
        }
    }
}
