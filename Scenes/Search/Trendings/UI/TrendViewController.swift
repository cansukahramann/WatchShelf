//
//  TrendViewController.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 17.09.2024.
//

import UIKit

final class TrendViewController: UIViewController {
    private let trendListView = TrendListView(frame: .zero)
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .systemBackground
        return scrollView
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    var viewModel: TrendListViewModel!
    
    override func viewDidLoad() {
        configureSearchController()
        super.viewDidLoad()
        setUpUI()
        configureUI()
        trendListView.delegate = self
    }
    
    private func configureSearchController() {
        let searchController = UISearchController()
        searchController.searchBar.placeholder = "Search and don’t get lost..."
        searchController.searchBar.delegate = self
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = searchController
    }
    
    private func setUpUI() {
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate( [
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            stackView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        ])
    }
    
    func configureUI() {
        stackView.addArrangedSubview(trendListView)
    }
}

extension TrendViewController: TrendListViewDelegate {
    func trendigAllSelected(id: Int, type: MediaType?) {
        if let mediaType = type {
            switch mediaType {
            case .movie:
                let movieDetailViewController = MovieDetailFactory.makeCastDetailVC(movieID: id)
                navigationController?.pushViewController(movieDetailViewController, animated: true)
            case .tv:
                let tvDetailViewController = TVShowDetailFactory.makeCastDetailVC(tvShowID: id)
                navigationController?.pushViewController(tvDetailViewController, animated: true)
            }
        }
    }
}

extension TrendViewController: UISearchBarDelegate {
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        navigationController?.pushViewController(SearchViewController(), animated: true)
        return false
    }
}
