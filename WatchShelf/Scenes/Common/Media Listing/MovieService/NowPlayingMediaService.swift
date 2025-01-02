//
//  NowPlayingMediaService.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 25.11.2024.
//

import Moya

struct NowPlayingMediaService: MediaServiceProtocol {
    func fetchMedia(requestModel: CommonRequestModel, completion: @escaping (Result<[Media], PresentableError>) -> Void) {
        NetworkManager.shared.request(ContentAPI.nowPlayingMovie(requestModel)) {
            let mappingResult: Result<MediaResponse, PresentableError> = ResponseMapper.map($0)
            completion(mappingResult.map({ $0.results }))
        }
    }
}
