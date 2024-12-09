//
//  TrendListViewModel.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 31.10.2024.
//

import Foundation
import Moya

protocol TrendListViewModelDelegate: AnyObject {
    func updateCollectionView()
}

final class TrendListViewModel  {
    weak var delegate: TrendListViewModelDelegate?
    private let service  = TrendListService()
    private var page = 1
    var model: [TrendingAll] = []
    private var isFetching = false
    
     func fetchTrendingList() {
         guard !isFetching else { return }
         isFetching = true
         
         service.loadTrendingAll(requestModel: CommonRequestModel(page: page)) { [weak self] result in
             self?.isFetching = false
            switch result {
            case .success(let response):
                self?.model.append(contentsOf: response)
                self?.delegate?.updateCollectionView()
                self?.page += 1
            case .failure(let failure):
                print(failure)
            }
        }
    }
}
