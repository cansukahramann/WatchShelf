//
//  ResponseMapper.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 16.12.2024.
//

import Foundation
import Moya

enum ResponseMapper {
    private static let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    static func map<T: Decodable>(_ result: Result<Response, Error>) -> Result<T, PresentableError> {
        switch result {
        case .success(let response):
            do {
                let data = response.data
                let mappedModel = try decoder.decode(T.self, from: data)
                return .success(mappedModel)
            } catch {
                return .failure(.generic)
            }
        case .failure:
            return .failure(.generic)
        }
    }
}
