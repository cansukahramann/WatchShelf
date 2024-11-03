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

class TrendListViewModel {
    
    private let provider = MoyaProvider<TrendingAPI>()
    var model = [TrendingAll]()
    weak var delegate: TrendListViewModelDelegate?

    func fetchTrendigAll() {
        provider.request(.trendingAll) { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let response):
                model = mapTredingAllResponse(from: response.data)!
                delegate?.updateCollectionView()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func mapTredingAllResponse(from data: Data) -> [TrendingAll]? {
        let response = try! JSONDecoder().decode(TrendingAllModel.self, from: data)
        return response.results
    }
}
