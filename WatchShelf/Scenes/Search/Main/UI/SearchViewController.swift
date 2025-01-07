//
//  SearchViewController.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 3.11.2024.
//

import UIKit

protocol SearchViewControllerDelegate: AnyObject {
    func selectedContent(id: Int, type: SearchResult.MediaType)
}

final class SearchViewController: UITableViewController {
    private let viewModel = SearchViewModel()
    let label = UILabel(
        text: "No results found",
        textColor: .secondaryLabel,
        font: UIFont.systemFont(ofSize: 16),
        textAlignment: .center
    )
    
    weak var delegate: SearchViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        title = "Search"
        tableView.separatorStyle = .none
        
        let searchController = UISearchController()
        searchController.searchBar.placeholder = "Search and don’t get lost..."
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
        tableView.register(SearchCell.self)
        tableView.register(IndicatorTableViewCell.self)
        viewModel.delegate = self
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        configureNoResultsLabel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.searchController?.searchBar.searchTextField.becomeFirstResponder()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if viewModel.model.isEmpty{
            return .zero
        }
        return viewModel.model.count + (viewModel.hasMoreItemsToLoad ? 1 : 0)
    }
    
    private func processResult(_ result: SearchResult) -> String {
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
        if indexPath.row != viewModel.model.count {
            let cell = tableView.dequeueCell(SearchCell.self, for: indexPath)
            let result = viewModel.model[indexPath.row]
            let displayName = processResult(result)
            cell.configure(result: result, displayName: displayName)
            return cell
        } else {
            let cell = tableView.dequeueCell(IndicatorTableViewCell.self, for: indexPath)
            cell.indicator.startAnimating()
            return cell
        }
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
            navigationController?.pushViewController(TVShowDetailFactory.makeCastDetailViewController(tvShowID: selectedId), animated: true)
        case .person:
            break
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == viewModel.model.count && viewModel.hasMoreItemsToLoad {
            return 20
        } else {
            let heightRatio: CGFloat = 0.16
            return tableView.frame.size.height * heightRatio
        }
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard indexPath.row >= viewModel.model.count - 3 else { return }
        viewModel.performSearchRequest()
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            viewModel.resetSearch()
            tableView.reloadData()
            label.isHidden = true
        } else {
            viewModel.search(searchText)
            label.isHidden = true
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.resetSearch()
        tableView.reloadData()
        label.isHidden = true
    }
}

extension SearchViewController: SearchViewModelDelegate {
    func didCompleteWith() {
        if viewModel.model.isEmpty {
            label.isHidden = false
        } else {
            label.isHidden = true
        }
        tableView.reloadData()
    }
    
    func didCompleteWithError() {
        tableView.reloadData()
        label.isHidden = true
        UIHelper.showHUDerror("search did compelte with error")
    }
}


