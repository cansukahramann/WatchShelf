//
//  AiringTodayMediaService.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 26.11.2024.
//

import Foundation
import Moya

struct AiringTodayMediaService: MediaServiceProtocol {
    func fetchMedia(requestModel: CommonRequestModel, completion: @escaping (Result<[Media], PresentableError>) -> Void) {
        NetworkManager.shared.request(ContentAPI.airingTodayTVShow(requestModel)) {
            let mappingResult: Result<MediaResponse, PresentableError> = ResponseMapper.map($0)
            completion(mappingResult.map({ $0.results }))
        }
    }
}