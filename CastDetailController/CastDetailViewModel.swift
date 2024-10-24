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
    
    var castID: Int
    private let provider = MoyaProvider<DetailAPI>()
    var castDetailModel: CastDetailModel!
    let group = DispatchGroup()
    
    init(castID: Int) {
        self.castID = castID
    }
    
    func fetchCastDetail() {
        group.enter()
        provider.request(.peopleDetail(personID: castID)) { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let response):
                castDetailModel = mapResponse(from: response.data)
            case.failure(let error):
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
}
