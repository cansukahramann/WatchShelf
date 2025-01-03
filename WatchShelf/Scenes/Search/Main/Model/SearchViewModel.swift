//
//  SearchViewModel.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 3.11.2024.
//

import Foundation
import Moya

protocol SearchViewModelDelegate: AnyObject {
    func didCompleteWith(results: [SearchResult])
    func didCompleteWithError()
}

final class SearchViewModel {
    weak var delegate: SearchViewModelDelegate?
    private var debounceTimer: Timer?
    private let service = SearchService()
    var model: [SearchResult] = []
    private var page = 1
    private(set) var isLoadingMore: Bool = false
    var isFetchingContent = false
    private var searchText: String = ""
    private var searchCancellationToken: Cancellable?
    
    private(set) var hasMoreItemsToLoad = true
    
    func search(_ searchText: String) {
        self.searchText = searchText
        debounceTimer?.invalidate()
        debounceTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { [weak self] _ in
            guard let self else { return }
            debounceTimer = nil
            performSearchRequest()
        }
    }
    
    func resetSearch() {
        model = []
        page = 1
        searchText = ""
        searchCancellationToken?.cancel()
    }
    
    func performSearchRequest() {
        guard !isLoadingMore, hasMoreItemsToLoad else { return }
        isLoadingMore = true
        searchCancellationToken = service.search(searchText: searchText, requestModel: CommonRequestModel(page: page)) { [weak self] result in
            self?.searchCancellationToken = nil
            
            switch result {
            case .success(let response):
                let filteredResults = response.filter { $0.mediaType != .person }
                self?.model.append(contentsOf: filteredResults)
                self?.hasMoreItemsToLoad = !filteredResults.isEmpty
                self?.page += 1
                self?.delegate?.didCompleteWith(results: self?.model ?? [])
            case .failure:
                self?.delegate?.didCompleteWithError()
            }
            self?.isLoadingMore = false
        }
    }
}
