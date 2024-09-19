//
//  CategoryViewController.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 17.09.2024.
//

import UIKit

enum MoviewCategory {
    case popular, upcoming
    var title: String {
        switch self {
        case .popular:
            ""
        case .upcoming:
            ""
        }
    }
    var url: String {
        switch self {
        case .popular:
            ""
        case .upcoming:
            ""
        }
    }
}

class CategoryViewController: UIViewController {
    
    var category: Category
    
    init(category: Category) {
        self.category = category
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupConstraints()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let layout = UIHelper.twoColumnHorizontalLayout(in: collectionView)
        collectionView.setCollectionViewLayout(layout, animated: false)
    }
    
    private var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.backgroundColor = .systemBackground
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private var categoryNameLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "SHREK"
        label.textAlignment = .left
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = 2
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private func setupConstraints() {
        view.addSubview(collectionView)
        view.addSubview(categoryNameLabel)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: categoryNameLabel.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 250),
            
            categoryNameLabel.topAnchor.constraint(equalTo: view.topAnchor),
            categoryNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            categoryNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12)
        ])
    }
}

extension CategoryViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PosterCell.reuseID, for: indexPath) as! PosterCell
        
        return cell
    }
}
