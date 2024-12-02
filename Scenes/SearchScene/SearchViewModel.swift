//
//  SearchViewModel.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 3.11.2024.
//

import Foundation

protocol SearchViewModelDelegate: AnyObject {
    func didCompleteWith(results: [SearchResponseModel.Result])
    func didCompleteWithError()
}

final class SearchViewModel {
    weak var delegate: SearchViewModelDelegate?
    private var debounceTimer: Timer?
    private let service = SearchService()
    var model: [SearchResponseModel.Result] = []
    private var page = 1
    private(set) var isLoadingMore: Bool = false
    var shouldRequestNextPage = true
    var isFetchingContent = false
    private var searchText: String = ""
    
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
    }
    
    func performSearchRequest() {
        guard !isLoadingMore else { return }
        isLoadingMore = true
        service.search(searchText: searchText, requestModel: CommonRequestModel(page: page)) { [weak self] result in
            switch result {
            case .success(let response):
                let filteredResults = response.results.filter { $0.mediaType != .person }
                self?.model.append(contentsOf: filteredResults)
                self?.delegate?.didCompleteWith(results: self?.model ?? [])
                self?.page += 1
            case .failure:
                self?.delegate?.didCompleteWithError()
            }
            self?.isLoadingMore = false
        }
    }
}
