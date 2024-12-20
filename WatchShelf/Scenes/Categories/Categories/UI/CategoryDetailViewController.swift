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

final class CategoryDetailViewController: UIViewController, CategoryDetailViewModelDelegate {
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
    
    private let button: UIButton = {
        let button = UIButton()
        button.setTitle("Movie", for: .normal)
        button.setImage(UIImage(systemName: "chevron.up.chevron.down"), for: .normal)
        button.configuration = .plain()
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .semibold)
        button.widthAnchor.constraint(greaterThanOrEqualToConstant: 100).isActive = true
        button.configuration?.titleTextAttributesTransformer =
        UIConfigurationTextAttributesTransformer { container in
            var container = container
            container.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
            return container
        }
        button.configuration?.imagePlacement = .trailing
        button.configuration?.imagePadding = 4
        button.configuration?.preferredSymbolConfigurationForImage = UIImage.SymbolConfiguration(pointSize: 14, weight: .medium, scale: .small )
        return button
    }()
    
    private var viewModel: CategoryDetailViewModel!
    
    convenience init(viewModel: CategoryDetailViewModel) {
        self.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CategoryDetailCell.self)
        collectionView.registerSupplementaryView(FooterCollectionReusableView.self, kind: UICollectionView.elementKindSectionFooter)
        setupUI()
        viewModel.delegate = self
        viewModel.fetchCategoryDetail()
        setupBarButtonWithContextMenu()
    }
    
    private func setupBarButtonWithContextMenu() {
        button.menu = makeMenu()
        button.showsMenuAsPrimaryAction = true
        let barButton = UIBarButtonItem(customView: button)
        navigationItem.rightBarButtonItem = barButton
    }
    
    
    private func makeMenu() -> UIMenu {
        let filterOption1 = UIAction(title: "Movie", image: Image.movieTypeSymbol) { [unowned self] _ in
            viewModel.contentType = .movie
            self.button.setTitle("Movie", for: .normal)
        }
        
        let filterOption2 = UIAction(title: "Tv Show", image: Image.tvTypeSymbol) { [unowned self] _ in
            viewModel.contentType = .tvShow
            self.button.setTitle("Tv Show", for: .normal)
        }
        
        return UIMenu(title: "Filter Options", children: [filterOption1, filterOption2])
        
    }
    
    private func setupUI() {
        view.addSubviews(collectionView, noContentLabel)
        
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
    }
    
    func setNoContentVisible(_ visible: Bool) {
        noContentLabel.isHidden = !visible
        collectionView.isHidden = visible
    }
}

extension CategoryDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.detailModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(CategoryDetailCell.self, for: indexPath)
        cell.configure(model: viewModel.detailModel[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionFooter {
            let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: FooterCollectionReusableView.identifier, for: indexPath) as! FooterCollectionReusableView
            return footer
        }
        return UICollectionReusableView()
    }
}

extension CategoryDetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let cell = cell as? CategoryDetailCell else { return }
        cell.configureRatingCircle(rating: viewModel.detailModel[indexPath.item].voteAverage ?? 0)
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        viewModel.hasMoreItemsToLoad ? CGSize(width: collectionView.frame.width, height: 100) : .zero
    }
}
