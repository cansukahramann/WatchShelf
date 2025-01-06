//
//  SimilarContentView.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 5.01.2025.
//

import UIKit

protocol BaseSimilarViewDelegate: AnyObject {
    func similarContentSelected(similarID: Int)
}

class SimilarContentView: UIView, SimilarContentViewModelDelegate {
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

    private var viewModel: SimilarContentViewModel!
    weak var delegate: BaseSimilarViewDelegate!
    var didSelectItem: ((_ id: Int) -> Void)?
    
    convenience init(viewModel: SimilarContentViewModel) {
        self.init(frame: .zero)
        self.viewModel = viewModel
        viewModel.delegate = self
        configureUI()
        viewModel.fetchSimilarContent()
        setupConstraints()
    }
    
    func configureUI() {
        collectionView.register(PosterCell.self)
        collectionView.register(IndicatorCell.self)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    func setupConstraints() {
        addSubviews(titleLabel,collectionView)
            
            NSLayoutConstraint.activate([
                titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 12),
                titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
                titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
                
                collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
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

extension SimilarContentView: UICollectionViewDataSource {
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
}


#warning("hele bura bak, bide burada yapılacak var")
extension SimilarContentView: UICollectionViewDelegateFlowLayout {
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
