//
//  CategoryDetailViewController.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 7.11.2024.
//

import UIKit

enum ContentType {
    case movie
    case tvShow
}

class CategoryDetailViewController: UIViewController,CategoryDetailViewModelDelegate {
    
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
    
    private let noContentLabel: UILabel = {
        let label = UILabel()
        label.text = "There is no content available for this category."
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .gray
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isHidden = true
        return label
    }()
    
    private var viewModel: CategoryDetailViewModel!
    let barButtonItem = UIBarButtonItem(image: UIImage(systemName: "ellipsis.circle"),
                                        style: .plain,
                                        target: nil ,
                                        action: nil)
    
    
    convenience init(viewModel: CategoryDetailViewModel) {
        self.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(IndicatorCell.self, forCellWithReuseIdentifier: IndicatorCell.reuseID)
        setupUI()
        viewModel.delegate = self
        viewModel.fetchCategoryDetail()
        setupBarButtonWithContextMenu()
    }
    
    private func setupBarButtonWithContextMenu() {
        let barButton = UIBarButtonItem(image: UIImage(systemName: "ellipsis.circle"), menu: makeMenu())
        navigationItem.rightBarButtonItem = barButton
        
    }
    
    private func makeMenu() -> UIMenu {
        
        let filterOption1 = UIAction(title: "Movie", image: Image.movieTypeSymbol) { _ in
            self.filterContent(type: .movie)
        }
        
        let filterOption2 = UIAction(title: "TV Show", image: Image.tvTypeSymbol) { _ in
            self.filterContent(type: .tvShow)
        }
        
        return UIMenu(title: "Filter Options", children: [filterOption1, filterOption2])
        
    }
    
    private func setupUI() {
        view.addSubviews(collectionView,noContentLabel)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            noContentLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            noContentLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            noContentLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            noContentLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    func updateCollectionView() {
        collectionView.reloadData()
        noContent()
    }
    
    func noContent() {
        noContentLabel.isHidden = !viewModel.detailModel.isEmpty
        collectionView.isHidden = viewModel.detailModel.isEmpty
    }
    
    private func filterContent(type: ContentType) {
        switch type {
        case .movie:
            viewModel.filteredMovies()
        case .tvShow:
            viewModel.filteredTVShow()
        }
        collectionView.reloadData()
    }
}

extension CategoryDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (viewModel.detailModel.count > 0) ? (viewModel.detailModel.count + 1) : 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item != viewModel.detailModel.count {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryDetailCell.reuseID, for: indexPath) as! CategoryDetailCell
            cell.configure(model: viewModel.detailModel[indexPath.item])
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: IndicatorCell.reuseID, for: indexPath) as! IndicatorCell
            cell.indicator.startAnimating()
            return cell
        }
    }
}

extension CategoryDetailViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let cell = cell as? CategoryDetailCell else { return }
        cell.configureRatingCircle(rating: viewModel.detailModel[indexPath.item].voteAverage ?? 0)
        
        if (indexPath.item == viewModel.detailModel.count ) && !viewModel.isFetchingContent && viewModel.shouldRequestNextPage {
            _ = (Int(viewModel.detailModel.count) / 20) + 1
            viewModel.fetchCategoryDetail()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.frame.size
        let cellHeight =  (indexPath.row == viewModel.detailModel.count && viewModel.isFetchingContent ) ? 20 : (size.height / 4)
        return CGSize(width: size.width , height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedItem = viewModel.detailModel[indexPath.item]
        let selectedId = selectedItem.id
        
        if selectedItem.isMovie {
            navigationController?.pushViewController(MovieDetailFactory.makeCastDetailVC(movieID: selectedId), animated: true)
        } else if selectedItem.isTVShow {
            navigationController?.pushViewController(TVShowDetailFactory.makeCastDetailVC(tvShowID: selectedId), animated: true)
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if offsetY >= contentHeight - (2 * height) {
            viewModel.fetchCategoryDetail()
            self.updateCollectionView()
        }
    }
}
