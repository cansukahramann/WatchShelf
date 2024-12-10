//
//  HorizontalMediaListingViewController.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 17.09.2024.
//

import UIKit
import Kingfisher

final class HorizontalMediaListingViewController: UIViewController, MediaListingViewModelDelegate {
    private var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: .zero, left: 16, bottom: .zero, right: 16)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemBackground
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private var categoryNameLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textAlignment = .left
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = 2
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var viewModel: MediaListingViewModel!
    var didSelectItem: ((_ id: Int) -> Void)?
    
    init(title: String, viewModel: MediaListingViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.title = title
        self.viewModel = viewModel
        viewModel.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(PosterCell.self, forCellWithReuseIdentifier: PosterCell.reuseID)
        collectionView.register(IndicatorCell.self, forCellWithReuseIdentifier: IndicatorCell.reuseID)
        setupConstraints()
        categoryNameLabel.text = title
        
        viewModel.fetchAllContent()
    }
    
    func updateCollectionView() {
        collectionView.reloadData()
    }
    
    private func setupConstraints() {
        view.addSubviews(collectionView,categoryNameLabel)
        
        NSLayoutConstraint.activate([
            categoryNameLabel.topAnchor.constraint(equalTo: view.topAnchor),
            categoryNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            categoryNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            
            collectionView.topAnchor.constraint(equalTo: categoryNameLabel.bottomAnchor,constant: 10),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 250)
        ])
    }
}

extension HorizontalMediaListingViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (viewModel.allContentResults.count > 0) ? (viewModel.allContentResults.count + 1) : 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item != viewModel.allContentResults.count {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PosterCell.reuseID, for: indexPath) as! PosterCell
            cell.configure(posterPath: viewModel.allContentResults[indexPath.item].posterPath)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: IndicatorCell.reuseID, for: indexPath) as! IndicatorCell
            cell.indicator.startAnimating()
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if (indexPath.item == viewModel.allContentResults.count ) && !viewModel.isFetchingContent && viewModel.shouldRequestNextPage{
            _ = (Int(viewModel.allContentResults.count) / 20) + 1
            viewModel.fetchAllContent()
        }
    }
}

extension HorizontalMediaListingViewController: UICollectionViewDelegateFlowLayout {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let offsetX = scrollView.contentOffset.x
        let contentWidth = scrollView.contentSize.height
        let width = scrollView.frame.size.width
        
        if offsetX >= contentWidth - (2 * width) {
            viewModel.fetchAllContent()
            self.updateCollectionView()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: (collectionView.bounds.width - 16) / 2 , height: collectionView.bounds.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedItemID = viewModel.allContentResults[indexPath.item].id
        didSelectItem?(selectedItemID)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        8
    }
}
