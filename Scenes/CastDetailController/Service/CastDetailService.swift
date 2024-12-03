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
    
    private var castDetailModel: CastDetailModel!
    private var movies = [CastCredit]()
    private var tvShows = [CastCredit]()
    private var castID: Int
    
    init(castID: Int) {
        self.castID = castID
    }
    
    func loadCastDetail(completion: @escaping(Result<(CastDetailModel, [CastCredit], [CastCredit]), Error>) -> Void) {
        loadPeopleDetail()
        loadPeopleMovieCredits()
        loadPeopleTVCredits()
    
        group.notify(queue: .main) { [weak self] in
            guard let self else { return }
            if let castDetail = castDetailModel {
                completion(.success((castDetail, movies, tvShows)))
            } else {
                let error = NSError(domain: "CastDetailService", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to load cast details"])
                completion(.failure(error))
            }
        }
    }
    
    private func loadPeopleDetail() {
        group.enter()
        NetworkManager.shared.request(DetailAPI.peopleDetail(castID: castID)) { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let response):
                castDetailModel = mapResponse(from: response.data)
            case.failure(let error):
                print(error)
            }
            group.leave()
        }
    }
    
    private func loadPeopleMovieCredits() {
        group.enter()
        NetworkManager.shared.request(DetailAPI.peopleMovieCredits(castID: castID)) { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let response):
                movies = mapCreditResponse(from: response.data)
            case .failure(let error):
                print(error)
            }
            group.leave()
        }
    }
    
    private func loadPeopleTVCredits()  {
        group.enter()
        NetworkManager.shared.request(DetailAPI.peopleTVCredits(castID: castID)) { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let response):
                tvShows = mapCreditResponse(from: response.data)
            case .failure(let error):
                print(error)
            }
            group.leave()
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
