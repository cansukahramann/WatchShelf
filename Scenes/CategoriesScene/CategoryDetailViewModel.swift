//
//  CategoryDetailViewModel.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 11.11.2024.
//

import Foundation
import Moya

protocol CategoryDetailViewModelDelegate: AnyObject {
    func updateCollectionView()
}

final class CategoryDetailViewModel {
    private let provider = MoyaProvider<DiscoverAPI>()
    var detailModel = [DiscoverResult]()
    var genreID: Int
    weak var delegate: CategoryDetailViewModelDelegate?
    
    init(genreID: Int) {
        self.genreID = genreID
    }
    
    func fetchDetail() {
        provider.request(.movie(genres: [genreID] )) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let response):
                detailModel = mapDetailResponse(from: response.data)
                delegate?.updateCollectionView()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func mapDetailResponse(from data: Data) -> [DiscoverResult] {
        let response = try! JSONDecoder().decode(DiscoverModel.self, from: data)
        return response.results
    }
}

