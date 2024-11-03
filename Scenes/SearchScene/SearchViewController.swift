//
//  SearchViewController.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 3.11.2024.
//

import UIKit

final class SearchViewController: UITableViewController {
    private let viewModel = SearchViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        title = "Search"
        
        let searchController = UISearchController()
        searchController.searchBar.placeholder = "Search and don’t get lost..."
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
        
        viewModel.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.searchController?.searchBar.searchTextField.becomeFirstResponder()
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.search(searchText)
    }
}

extension SearchViewController: SearchViewModelDelegate {
    func didCompleteWith(results: [SearchResponseModel.Result]) {
        print(results)
    }
    
    func didCompleteWithError() {
        print("search did compelte with error")
    }
}
