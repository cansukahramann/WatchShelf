//
//  CategoryDetailService.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 20.11.2024.
//

import Foundation
import Moya

final class CategoryDetailService {
    private var genreID: Int
    
    init(genreID: Int) {
        self.genreID = genreID
    }
    
    func loadCategoryDetail(contentType: ContentType, requestModel: CommonRequestModel, completion: @escaping(Result<([DiscoverResult]), PresentableError>) -> Void) {
        switch contentType {
        case .movie:
            loadMovieGenre(requestModel: requestModel, completion: completion)
        case .tvShow:
            loadTVGenre(requestModel: requestModel, completion: completion)
        }
    }
    
    private func loadMovieGenre(requestModel: CommonRequestModel, completion: @escaping(Result<([DiscoverResult]), PresentableError>) -> Void) {
        NetworkManager.shared.request(DiscoverAPI.movie(genres: [genreID], requestModel: requestModel)) {
            let mappingResult: Result<DiscoverModel, PresentableError> = ResponseMapper.map($0)
            completion(mappingResult.map({ $0.results }))
        }
    }
    
    private func loadTVGenre(requestModel: CommonRequestModel, completion: @escaping(Result<([DiscoverResult]), PresentableError>) -> Void) {
        NetworkManager.shared.request(DiscoverAPI.tv(genres: [genreID], requestModel: requestModel)) {
            let mappingResult: Result<DiscoverModel, PresentableError> = ResponseMapper.map($0)
            completion(mappingResult.map({ $0.results }))
        }
    }
}
