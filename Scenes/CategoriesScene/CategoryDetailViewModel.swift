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
    var group = DispatchGroup()
    
    init(genreID: Int) {
        self.genreID = genreID
    }
    
    func fetchDetail() {
        group.enter()
        provider.request(.movie(genres: [genreID] )) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let response):
                let movies = mapDetailResponse(from: response.data)
                self.detailModel.append(contentsOf: movies)
            case .failure(let error):
                print(error)
            }
            group.leave()
        }
        group.enter()
        provider.request(.tv(genres: [genreID])) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let response):
                let tvShows = mapDetailResponse(from: response.data)
                self.detailModel.append(contentsOf: tvShows)
            case .failure(let error):
                print(error)
            }
            group.leave()
        }
        group.notify(queue: .main) {
            self.delegate?.updateCollectionView()
        }
    }
    
    private func mapDetailResponse(from data: Data) -> [DiscoverResult] {
        let response = try! JSONDecoder().decode(DiscoverModel.self, from: data)
        return response.results
    }
}

