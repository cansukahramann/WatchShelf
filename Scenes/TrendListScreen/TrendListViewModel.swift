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
    var model: [TrendingAll] = []
    
     func fetchTrendingList() {
         service.loadTrendingAll { [weak self] result in
            switch result {
            case .success(let response):
                self?.model = response
                self?.delegate?.updateCollectionView()
            case .failure(let failure):
                print(failure)
            }
        }
    }
}
