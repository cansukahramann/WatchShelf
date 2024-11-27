//
//  CategoryDetailService.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 20.11.2024.
//

import Foundation
import Moya

final class CategoryDetailService {
    private let provider = MoyaProvider<DiscoverAPI>()
    private var group = DispatchGroup()
    
    func loadCategoryDetail(genreID: Int,requestModel: CommonRequestModel, completion: @escaping(Result<([DiscoverResult]),Error>) -> Void) {
        var detailModel = [DiscoverResult]()
        
        group.enter()
        provider.request(.movie(genres: [genreID],requestModel: requestModel)) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let response):
                let movies = mapDetailResponse(from: response.data)
                detailModel.append(contentsOf: movies)
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
                detailModel.append(contentsOf: tvShows)
            case .failure(let error):
                print(error)
            }
            group.leave()
        }
        group.notify(queue: .main) {
            completion(.success(detailModel))
        }
    }
    private func mapDetailResponse(from data: Data) -> [DiscoverResult] {
        let response = try! JSONDecoder().decode(DiscoverModel.self, from: data)
        return response.results
    }
}
