//
//  CategoryDetailViewController.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 7.11.2024.
//

import UIKit

class CategoryDetailViewController: UIViewController,CategoryDetailViewModelDelegate {
    func updateCollectionView() {
        collectionView.reloadData()
    }
    
    private var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let padding: CGFloat = 8 
        let numberOfItemsPerRow: CGFloat = 2
        let availableWidth = UIScreen.main.bounds.width - (padding * (numberOfItemsPerRow + 1))
        let itemWidth = availableWidth / numberOfItemsPerRow
        
        layout.itemSize = CGSize(width: itemWidth, height: 250)
        layout.minimumLineSpacing = padding
        layout.minimumInteritemSpacing = padding
        layout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(CategoryDetailCell.self, forCellWithReuseIdentifier: CategoryDetailCell.reuseID)
        collectionView.backgroundColor = .systemBackground
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    private var viewModel: CategoryDetailViewModel!
    
    convenience init(genreID: Int) {
        self.init(nibName: nil, bundle: nil)
        viewModel = CategoryDetailViewModel(genreID: genreID)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        setupUI()
        viewModel.delegate = self
        viewModel.fetchDetail()
    }

    private func setupUI() {
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension CategoryDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.detailModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryDetailCell.reuseID, for: indexPath) as! CategoryDetailCell
        cell.configure(model: viewModel.detailModel[indexPath.item])
        return cell
    }
}

extension CategoryDetailViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let cell = cell as? CategoryDetailCell else { return }
        cell.configureRatingCircle(rating: viewModel.detailModel[indexPath.item].voteAverage ?? 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedItem = viewModel.detailModel[indexPath.item]
        let selectedId = selectedItem.id
        
        if selectedItem.isMovie {
            navigationController?.pushViewController(MovieDetailViewController(movieID: selectedId), animated: true)
        } else if selectedItem.isTVShow {
            navigationController?.pushViewController(TVShowDetailViewController(tvShowID: selectedId), animated: true)
        }
        
    }
}
