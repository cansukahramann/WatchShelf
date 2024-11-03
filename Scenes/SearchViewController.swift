//
//  SearchViewController.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 17.09.2024.
//

import UIKit

class SearchViewController: UIViewController {
    
    private let searchListView = SearchListView(frame: .zero)
    
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

    var viewModel: SearchListViewModel!
    
    override func viewDidLoad() {
        configureSearchController()
        super.viewDidLoad()
        setUpUI()
        configureUI()
        didFetchTrending()
        
    }
    
    func configureSearchController() {
        let searchController = UISearchController()
        searchController.searchBar.placeholder = "Search and don’t get lost..."
        searchController.searchBar.searchTextField.isUserInteractionEnabled = false
        searchController.searchBar.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(searchBarTapped)))
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = searchController
    }
    
    @objc private func searchBarTapped() {
        print("Did tap search bar")
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
        stackView.addArrangedSubview(searchListView)
    }
    
    func didFetchTrending() {
        searchListView.didFetchTrending()
    }
    
    func trendigAllSelected(id: Int, type: MediaType?) {
        if let mediaType = type {
            switch mediaType {
            case .movie:
                let movieDetailViewController = DetailViewController(movieID: id)
                navigationController?.pushViewController(movieDetailViewController, animated: true)
            case .tv:
                let tvDetailViewController = TVShowDetailViewController(tvShowID: id)
                navigationController?.pushViewController(tvDetailViewController, animated: true)
            }
        }
    }
}

