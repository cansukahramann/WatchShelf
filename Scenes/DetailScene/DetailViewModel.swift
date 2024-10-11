//
//  DetailViewModel.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 8.10.2024.
//

import Foundation
import Moya

protocol DetailViewModelDelegate: AnyObject {
    func updateUI(model: DetailModel)
}

class DetailViewModel {
    
    private let detailProvider = MoyaProvider<DetailAPI>()
    var movieID: Int
    var detailModel: DetailModel!
    var similarModel = [SimilarResult]()
    let group = DispatchGroup()

    weak var delegate: DetailViewModelDelegate?
    
    init(movieID: Int) {
        self.movieID = movieID
    }
    
    func fetchDetail() {
        group.enter()
        detailProvider.request(.movieDetail(movieID: movieID)) { [weak self] result in
            guard let self else { return }
            
            switch result {
            case.success(let response):
                detailModel = mapResponse(from: response.data)
                delegate?.updateUI(model: detailModel)
            case.failure(let error):
                print(error)
            }
            group.leave()
        }
        group.enter()
        detailProvider.request(.movieSimilar(movieID: movieID)) { [weak self] result in
            guard let self else { return }
            switch result {
            case.success(let response):
                similarModel = mapResponseDetail(from: response.data)!
            case.failure(let error):
                print(error)
            }
        }
        group.leave()
        
        group.notify(queue: .main) {
            print("perfect")
        }
    }
    
    
   
    private func mapResponse(from data: Data) -> DetailModel? {
        let response = try! JSONDecoder().decode(DetailModel.self, from: data)
        return response
    }
    
    private func mapResponseDetail(from data: Data) -> [SimilarResult]? {
        let response = try! JSONDecoder().decode(SimilarModel.self, from: data)
        return response.results
    }
}
