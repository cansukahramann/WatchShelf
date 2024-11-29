//
//  CastDetailService.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 13.11.2024.
//

import Foundation
import Moya

final class CastDetailService {
    private let group = DispatchGroup()
    private let provider = MoyaProvider<DetailAPI>()
   
    
    func loadCastDetail(castID: Int, completion: @escaping(Result<(CastDetailModel, [CastCredit], [CastCredit]), Error>) -> Void) {
        var castDetailModel: CastDetailModel!
        var movies = [CastCredit]()
        var tvShows = [CastCredit]()

        group.enter()
        provider.request(.peopleDetail(castID: castID)) { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let response):
                castDetailModel = mapResponse(from: response.data)
            case.failure(let error):
                print(error)
            }
            group.leave()
        }
        group.enter()
        provider.request(.peopleMovieCredits(castID: castID)) { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let response):
                movies = mapCreditResponse(from: response.data)
            case .failure(let error):
                print(error)
            }
            group.leave()
        }
        group.enter()
        provider.request(.peopleTVCredits(castID: castID)) { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let response):
                tvShows = mapCreditResponse(from: response.data)
            case .failure(let error):
                print(error)
            }
            group.leave()
        }
        
        group.notify(queue: .main) {
            if let castDetail = castDetailModel {
                completion(.success((castDetail, movies, tvShows)))
            } else {
                let error = NSError(domain: "CastDetailService", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to load cast details"])
                completion(.failure(error))
            }
        }
    }
    private func mapResponse(from data: Data) -> CastDetailModel? {
        let response = try! JSONDecoder().decode(CastDetailModel.self, from: data)
        return response
    }
    
    private func mapCreditResponse(from data: Data) -> [CastCredit] {
        let response = try! JSONDecoder().decode(CastCredits.self, from: data)
        return response.cast
    }
}
