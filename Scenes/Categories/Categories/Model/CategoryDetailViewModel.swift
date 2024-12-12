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
    func setNoContentVisible(_ visible: Bool)
}

final class CategoryDetailViewModel {
    var detailModel: [DiscoverResult] = []
    var genreID: Int
    weak var delegate: CategoryDetailViewModelDelegate?
    private let service: CategoryDetailService!
    private var shouldRequestNextPage = true
    var isFetchingContent = false
    private var page = 1
    var hasMoreItemsToLoad: Bool {
        shouldRequestNextPage
    }
    
    var contentType: ContentType = .movie {
        didSet {
            reset()
            fetchCategoryDetail()
        }
    }
    
    private func checkEmptyContent() {
        delegate?.setNoContentVisible(detailModel.isEmpty)
    }
    
    private func reset() {
        page = 1
        detailModel = []
        delegate?.setNoContentVisible(false)
    }
    
    init(service: CategoryDetailService, genreID: Int) {
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
                if detailModel.isEmpty, page != 1 {
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

