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
    var detailModel: [DiscoverResult] = []
    var genreID: Int
    weak var delegate: CategoryDetailViewModelDelegate?
    private let service: CategoryDetailService!
    var shouldRequestNextPage = true
    var isFetchingContent = false
    private var page = 1
    var contentType: ContentType = .movie {
        didSet {
            reset()
            fetchCategoryDetail()
        }
    }
    
    private func checkEmptyContent() {
        if detailModel.isEmpty {
            delegate?.updateCollectionView()
        }
    }
    
    private func reset() {
        page = 1
        detailModel = []
        delegate?.updateCollectionView()
    }
    
    init(service: CategoryDetailService,genreID: Int) {
        self.service = service
        self.genreID = genreID
    }
    
    func fetchCategoryDetail() {
        guard !isFetchingContent, shouldRequestNextPage else { return }
        isFetchingContent = true
        
        service.loadCategoryDetail(contentType: contentType, requestModel: CommonRequestModel(page: page)) { [weak self] result in
            guard let self else { return }
            self.isFetchingContent = false
            
            switch result {
            case .success(let (detailModel)):
                if detailModel.isEmpty {
                    self.shouldRequestNextPage = false
                }
                self.detailModel.append(contentsOf: detailModel)
                self.checkEmptyContent()
                self.delegate?.updateCollectionView()
                page += 1
            case .failure(let error):
                print(error)
                self.shouldRequestNextPage = false
            }
        }
    }
}

