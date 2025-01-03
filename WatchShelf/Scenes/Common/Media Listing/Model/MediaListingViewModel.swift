//
//  MediaListingViewModel.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 23.09.2024.
//

import Foundation
import Moya

protocol MediaListingViewModelDelegate: AnyObject {
    func updateCollectionView()
}

final class MediaListingViewModel {
    weak var delegate: MediaListingViewModelDelegate?
    private let service: MediaServiceProtocol
    
    private(set) var MediaList = [Media]()
    private var page = 1
    private var shouldRequestNextPage = true
    private var isFetchingContent = false
    
    var hasLoadingIndicator: Bool {
        shouldRequestNextPage
    }
    
    init(service: MediaServiceProtocol) {
        self.service = service
    }
    
    func fetchAllContent() {
        guard !isFetchingContent, shouldRequestNextPage else { return }
        isFetchingContent = true
        service.fetchMedia(requestModel: CommonRequestModel(page: page)) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let results):
                self.MediaList.append(contentsOf: results)
                self.page += 1
                self.shouldRequestNextPage = !results.isEmpty
            case .failure(let error):
                UIHelper.showHUDerror(error.localizedDescription)
            }
            delegate?.updateCollectionView()
            isFetchingContent = false
        }
    }
}
