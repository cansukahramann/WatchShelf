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

final class CastDetailViewModel {
    
    private var castID: Int
    var castDetailModel: CastDetailModel!
    var movies = [CastCredit]()
    var tvShows = [CastCredit]()
    private let service: CastDetailService!
    weak var delegate: CastDetailViewModelDelegate?

    init(service: CastDetailService,castID: Int) {
        self.service = service
        self.castID = castID
    }
    
    func fetchCastDetail() {
        service.loadCastDetail  { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let (detailModel, movies, tvShows) ):
                self.castDetailModel = detailModel
                self.movies = movies
                self.tvShows = tvShows
                self.delegate?.didFetchCastDetail()
            case .failure(let error):
                print(error)
            }
        }
    }
}
