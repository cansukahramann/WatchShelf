//
//  MediaServiceProtocol.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 25.11.2024.
//

import Foundation

protocol MediaServiceProtocol {
    func fetchMedia(requestModel: CommonRequestModel, completion: @escaping (Result<[Media], Error>) -> Void)
}

extension MediaServiceProtocol {
    func map(data: Data) -> Result<[Media], Error> {
        do {
            let decoder = JSONDecoder()
            let decodedModel = try decoder.decode(MediaResponseModel.self, from: data)
            return(.success(decodedModel.results))
        } catch {
            return(.failure(error))
        }
    }
}
