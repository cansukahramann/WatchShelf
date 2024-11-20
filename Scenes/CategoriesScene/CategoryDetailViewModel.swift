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
    
    var detailModel = [DiscoverResult]()
    var genreID: Int
    weak var delegate: CategoryDetailViewModelDelegate?
    private let service: CategoryDetailService!
 
    init(service: CategoryDetailService,genreID: Int) {
        self.service = service
        self.genreID = genreID
    }
    
    func fetchCategoryDetail() {
        service.loadCategoryDetail(genreID: genreID) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let (detailModel)):
                self.detailModel = detailModel
                self.delegate?.updateCollectionView()
            case .failure(let error):
                print(error)
            }
        }
    }
}

