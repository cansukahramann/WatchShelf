//
//  CastDetailViewModel.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 20.10.2024.
//

import Foundation
import Moya

protocol CastDetailViewModelDelegate: AnyObject {
    func didFetchCastDetail()
}

class CastDetailViewModel {
    
    weak var delegate: CastDetailViewModelDelegate?
    
    var personID: Int
    private let provider = MoyaProvider<DetailAPI>()
    var castDetailModel: CastDetailModel!
    var movies = [CastCredit]()
    var tvShows = [CastCredit]()
    let group = DispatchGroup()
    
    init(castID: Int) {
        self.personID = castID
    }
    
    func fetchCastDetail() {
        group.enter()
        provider.request(.peopleDetail(personID: personID)) { [weak self] result in
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
        provider.request(.peopleMovieCredits(personID: personID)) { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let response):
                movies = mapCreditResponse(from: response.data)
            case .failure(let error):
                print(error)
            }
            group.leave()
        }
        group.enter()
        provider.request(.peopleTVCredits(personID: personID)) { [weak self] result in
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
            self.delegate?.didFetchCastDetail()
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
