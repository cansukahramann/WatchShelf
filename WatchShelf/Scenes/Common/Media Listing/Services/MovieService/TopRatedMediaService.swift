//
//  TopRatedMediaService.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 25.11.2024.
//

import Foundation
import Moya

struct TopRatedMediaService: MediaServiceProtocol {
    func fetchMedia(requestModel: CommonRequestModel, completion: @escaping (Result<[Media], PresentableError>) -> Void) {
        NetworkManager.shared.request(ContentAPI.topRatedMovie(requestModel)) {
            let mappingResult: Result<MediaResponseModel, PresentableError> = ResponseMapper.map($0)
            completion(mappingResult.map({ $0.results }))
        }
    }
}
