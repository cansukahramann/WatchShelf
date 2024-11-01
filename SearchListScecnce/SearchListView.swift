//
//  SearchListView.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 31.10.2024.
//

import UIKit

protocol SearchListViewDelegate: AnyObject {
    func trendigAllSelected(id: Int, type: MediaType?)
}

class SearchListView: UIView, SearchListViewModelDelegate {
    
    private var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemBackground
        collectionView.showsVerticalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    var viewModel =  SearchListViewModel()
    weak var delegate: SearchListViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        viewModel.delegate = self
        collectionView.register(PosterCell.self, forCellWithReuseIdentifier: PosterCell.reuseID)
        collectionView.dataSource = self
        collectionView.delegate = self
        setupConstraint()
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraint() {
        addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 350)
        ])
    }
    
    func updateCollectionView() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func didFetchTrending() {
        viewModel.fetchTrendigAll()
    }
}

extension SearchListView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.model.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PosterCell.reuseID, for: indexPath) as! PosterCell
        cell.configureTrendingAll(model: viewModel.model[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedTrend = viewModel.model[indexPath.item]
        let selectedId = selectedTrend.id
        let selectedMediaType = selectedTrend.type
        
        delegate?.trendigAllSelected(id: selectedId, type: selectedMediaType)
        
    }
}

extension SearchListView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width / 2) - 8
        let height: CGFloat = 300
        return CGSize(width: width, height: height)
    }
}
