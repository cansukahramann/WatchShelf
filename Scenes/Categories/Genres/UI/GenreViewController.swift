//
//  GenreViewController.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 7.11.2024.
//

import UIKit

final class GenreViewController: UIViewController,GenreViewModelDelegate {
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let numberOfItemsInRow: CGFloat = 2
        let padding: CGFloat = 10
        let width = (UIScreen.main.bounds.width - (numberOfItemsInRow + 1 ) * padding) / numberOfItemsInRow
        layout.itemSize = CGSize(width: width, height: width)
        layout.minimumInteritemSpacing = padding
        layout.minimumLineSpacing = padding
        layout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemBackground
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(GenreCell.self, forCellWithReuseIdentifier: GenreCell.reuseID)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    var viewModel: GenreViewModel!
    
    convenience init(viewModel: GenreViewModel!) {
        self.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        setupUI()
        viewModel.delegate = self
        viewModel.fetchGenre()
    }
    
    private func setupUI() {
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 300)
        ])
    }
    
    func updateCollectionView() {
        collectionView.reloadData()
    }
}

extension GenreViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.genreModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GenreCell.reuseID, for: indexPath) as! GenreCell
        cell.configure(model: viewModel.genreModel[indexPath.item])
        return cell
    }
}

extension GenreViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? GenreCell else { return }
        cell.animateCellTap { [unowned self] in
            let categoryDetailVC = CategoryDetailFactory.makeCategoryDetailVC(genreID: viewModel.genreModel[indexPath.item].id)
            self.navigationController?.pushViewController(categoryDetailVC, animated: true)
        }
    }
}
