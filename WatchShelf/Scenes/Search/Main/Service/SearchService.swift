//
//  SearchService.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 3.11.2024.
//

import Foundation
import Moya

final class SearchService {
    func search(searchText: String,requestModel: CommonRequestModel, completion: @escaping (Result<[SearchResult], PresentableError>) -> Void) -> Cancellable {
        NetworkManager.shared.request(SearchAPI.multi(query: searchText, requestModel: requestModel)) {
            let mappingResult: Result<SearchResponse, PresentableError> = ResponseMapper.map($0)
            completion(mappingResult.map({ $0.results }))
        }
    }
}
