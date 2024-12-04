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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        title = "Search"
        
        let searchController = UISearchController()
        searchController.searchBar.placeholder = "Search and don’t get lost..."
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
        tableView.register(SearchCell.self, forCellReuseIdentifier: "SearchCell")
        tableView.register(IndicatorTableViewCell.self, forCellReuseIdentifier: IndicatorTableViewCell.reuseID)
        viewModel.delegate = self
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.searchController?.searchBar.searchTextField.becomeFirstResponder()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        (viewModel.model.count > 0) ? (viewModel.model.count + 1) : 0
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
        if indexPath.row != viewModel.model.count {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell", for: indexPath) as! SearchCell
            let result = viewModel.model[indexPath.row]
            let displayName = processResult(result)
            cell.configure(result: result, displayName: displayName)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: IndicatorTableViewCell.reuseID, for: indexPath) as! IndicatorTableViewCell
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
            navigationController?.pushViewController(TVShowDetailFactory.makeCastDetailVC(tvShowID: selectedId), animated: true)
        case .person:
            break
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == viewModel.model.count && viewModel.isFetchingContent {
            return 20
        } else {
            let heightRatio: CGFloat = 0.16
            return tableView.frame.size.height * heightRatio
        }
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == viewModel.model.count && !viewModel.isFetchingContent && viewModel.shouldRequestNextPage {
            _ = (Int(viewModel.model.count) / 20) + 1
            viewModel.performSearchRequest()
        }
    }
    
    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if offsetY >= contentHeight - (2 * height), !viewModel.model.isEmpty {
            viewModel.performSearchRequest()
        }
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            viewModel.resetSearch()
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


