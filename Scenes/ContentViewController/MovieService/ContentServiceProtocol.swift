//
//  ContentServiceProtocol.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 25.11.2024.
//

import Foundation

protocol ContentServiceProtocol {
    func fetchContent(requestModel: CommonRequestModel, completion: @escaping (Result<[ContentResult], Error>) -> Void)
}

extension ContentServiceProtocol {
    func map(data: Data) -> Result<[ContentResult], Error> {
        do {
            let decoder = JSONDecoder()
            let decodedModel = try decoder.decode(ContentModel.self, from: data)
            return(.success(decodedModel.results))
        } catch {
            return(.failure(error))
        }
    }
}
