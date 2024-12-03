//
//  CategoryDetailService.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 20.11.2024.
//

import Foundation
import Moya

final class CategoryDetailService {
    private var group = DispatchGroup()
    var detailModel = [DiscoverResult]()
    
    func loadCategoryDetail(genreID: Int,requestModel: CommonRequestModel, completion: @escaping(Result<([DiscoverResult]),Error>) -> Void) {
        var detailModel = [DiscoverResult]()
        
        group.enter()
        NetworkManager.shared.request(DiscoverAPI.movie(genres: [genreID],requestModel: requestModel)) { [weak self] result in
                  guard let self else { return }
                  switch result {
                  case .success(let response):
                      print("Response Data: \(String(data: response.data, encoding: .utf8) ?? "")")
                      let movies = mapDetailResponse(from: response.data)
                      detailModel.append(contentsOf: movies)
                  case .failure(let error):
                      print(error)
                  }
                  group.leave()
              }
              group.enter()
        NetworkManager.shared.request(DiscoverAPI.tv(genres: [genreID])) { [weak self] result in
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
