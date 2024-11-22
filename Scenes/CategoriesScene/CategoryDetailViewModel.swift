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
    func noContent()
}

final class CategoryDetailViewModel {
    var allItems: [DiscoverResult] = []
    var detailModel = [DiscoverResult]()
    var genreID: Int
    weak var delegate: CategoryDetailViewModelDelegate?
    private let service: CategoryDetailService!
    
    func filteredMovies() {
        detailModel = allItems.filter { $0.isMovie }
        delegate?.noContent()
    }
    
    func filteredTVShow() {
        detailModel = allItems.filter { $0.isTVShow}
        delegate?.noContent()
    }
    
    private func checkEmptyContent() {
        if detailModel.isEmpty {
            delegate?.updateCollectionView()
        }
    }
    
    init(service: CategoryDetailService,genreID: Int) {
        self.service = service
        self.genreID = genreID
    }
    
    func fetchCategoryDetail() {
        service.loadCategoryDetail(genreID: genreID) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let (detailModel)):
                self.allItems = detailModel
                self.detailModel = detailModel
                self.checkEmptyContent()
                self.delegate?.updateCollectionView()
            case .failure(let error):
                print(error)
            }
        }
    }
}

