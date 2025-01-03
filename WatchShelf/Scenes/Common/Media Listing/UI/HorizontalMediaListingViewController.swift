//
//  HorizontalMediaListingViewController.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 17.09.2024.
//

import UIKit
import Kingfisher

final class HorizontalMediaListingViewController: UIViewController, MediaListingViewModelDelegate {
    var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: .zero, left: 16, bottom: .zero, right: 16)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemBackground
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    let categoryNameLabel = UILabel(font: UIFont.boldSystemFont(ofSize: 20), numberOfLines: 2)
    
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
        collectionView.register(PosterCell.self)
        collectionView.register(IndicatorCell.self)
        setupConstraints()
        categoryNameLabel.text = title
        
        viewModel.fetchAllContent()
    }
    
    func updateCollectionView() {
        collectionView.reloadData()
    }
}

extension HorizontalMediaListingViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.MediaList.isEmpty ? .zero : viewModel.MediaList.count + (viewModel.hasLoadingIndicator ? 1 : .zero)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let lastIndex = viewModel.MediaList.count
        let currentIndex = indexPath.item
        
        if viewModel.hasLoadingIndicator && currentIndex == lastIndex {
            let cell = collectionView.dequeueCell(IndicatorCell.self, for: indexPath)
            cell.indicator.startAnimating()
            return cell
        } else {
            let cell = collectionView.dequeueCell(PosterCell.self, for: indexPath)
            cell.configure(posterPath: viewModel.MediaList[indexPath.item].posterPath)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard indexPath.item == viewModel.MediaList.count - 3 else { return }
        viewModel.fetchAllContent()
    }
}

extension HorizontalMediaListingViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: (collectionView.bounds.width - 16) / 2, height: collectionView.bounds.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedItemID = viewModel.MediaList[indexPath.item].id
        didSelectItem?(selectedItemID)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        8
    }
}
