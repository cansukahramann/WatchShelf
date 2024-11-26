//
//  ContentViewController.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 17.09.2024.
//

import UIKit
import Kingfisher

class ContentViewController: UIViewController, ContentViewModelDelegate {
    
    private var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
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
    
    private var viewModel: ContentViewModel!
    var didSelectItem: ((_ id: Int) -> Void)? 
    
    init(title: String, viewModel: ContentViewModel) {
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
        setupConstraints()
        categoryNameLabel.text = title
        
        viewModel.fetchAllContent()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let layout = UIHelper.twoColumnHorizontalLayout(in: collectionView)
        collectionView.setCollectionViewLayout(layout, animated: false)
    }
    
    func updateCollectionView() {
        collectionView.reloadData()
    }
    
    
    private func setupConstraints() {
        view.addSubview(collectionView)
        view.addSubview(categoryNameLabel)
        
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

extension ContentViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.allContentResults.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PosterCell.reuseID, for: indexPath) as! PosterCell
        cell.configure(posterPath: viewModel.allContentResults[indexPath.item].posterPath)
        return cell
    }
}

extension ContentViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedItemID = viewModel.allContentResults[indexPath.item].id
        didSelectItem?(selectedItemID)
    }
}
