//
//  SimilarServiceProtocol.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 30.11.2024.
//

import Foundation

protocol SimilarServiceProtocol {
    func similarContentSelected(similarID: Int,requestModel: CommonRequestModel, completion: @escaping(Result<[SimilarResult], Error>) -> Void)
}

extension SimilarServiceProtocol {
    func mapResponseDetail(from data: Data) -> Result <[SimilarResult], Error> {
        do {
            let decoder = JSONDecoder()
            let decodedModel = try decoder.decode(SimilarModel.self, from: data)
            return (.success(decodedModel.results))
        } catch {
            return (.failure(error))
        }
    }
}
