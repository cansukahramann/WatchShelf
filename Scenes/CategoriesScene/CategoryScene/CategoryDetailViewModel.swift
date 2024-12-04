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
    var shouldRequestNextPage = true
    var isFetchingContent = false
    private var page = 1
    
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
        service.loadCategoryDetail(requestModel: CommonRequestModel(page: page)) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let (detailModel)):
                self.allItems = detailModel
                self.detailModel.append(contentsOf: detailModel)
                self.checkEmptyContent()
                self.delegate?.updateCollectionView()
                page += 1
            case .failure(let error):
                print(error)
            }
        }
    }
}

