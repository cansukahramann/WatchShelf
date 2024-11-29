//
//  SearchViewController.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 3.11.2024.
//

import UIKit

protocol SearchViewControllerDelegate: AnyObject {
    func selectedContent(id: Int, type: SearchResponseModel.Result.MediaType)
}

final class SearchViewController: UITableViewController {
    private let viewModel = SearchViewModel()
    weak var delegate: SearchViewControllerDelegate?
    private var lastSearchText: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        title = "Search"
        
        let searchController = UISearchController()
        searchController.searchBar.placeholder = "Search and don’t get lost..."
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
        tableView.register(SearchCell.self, forCellReuseIdentifier: "SearchCell")
        viewModel.delegate = self
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.searchController?.searchBar.searchTextField.becomeFirstResponder()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.model.count
    }
    
    func processResult(_ result: SearchResponseModel.Result) -> String {
        let title = result.title?.trimmingCharacters(in: .whitespacesAndNewlines)
        let name = result.name?.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if let title = title, !title.isEmpty {
            return title
        } else if let name = name, !name.isEmpty {
            return name
        } else {
            return "-"
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell", for: indexPath) as! SearchCell
        let result = viewModel.model[indexPath.row]
        let displayName = processResult(result)
        cell.configure(result: result, displayName: displayName)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedContent = viewModel.model[indexPath.row]
        let selectedId = selectedContent.id
        let selectedMediaType = selectedContent.mediaType
        delegate?.selectedContent(id: selectedId, type: selectedMediaType)
        
        switch selectedMediaType {
        case .movie:
            navigationController?.pushViewController(MovieDetailFactory.makeCastDetailVC(movieID: selectedId), animated: true)
        case .tv:
            navigationController?.pushViewController(TVShowDetailFactory.makeCastDetailVC(seriesID: selectedId), animated: true)
        case .person:
            break
        }
    }
    
    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if offsetY >= contentHeight - (2 * height), !viewModel.model.isEmpty {
            viewModel.performSearchRequest(searchText: lastSearchText)
            self.tableView.reloadData()
        }
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        lastSearchText = searchText
        if searchText.isEmpty {
            viewModel.model.removeAll()
            tableView.reloadData()
        } else {
            viewModel.search(searchText)
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.model.removeAll()
        tableView.reloadData()
    }
}

extension SearchViewController: SearchViewModelDelegate {
    func didCompleteWith(results: [SearchResponseModel.Result]) {
        viewModel.model = results
        if !viewModel.model.isEmpty {
            tableView.reloadData()
        }
    }
    
    func didCompleteWithError() {
        print("search did compelte with error")
    }
}

