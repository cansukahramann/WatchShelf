//
//  NetworkManager.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 3.12.2024.
//

import Foundation
import Moya

final class NetworkManager {
    
    static let shared = NetworkManager()
    private let provider = MoyaProvider<MultiTarget>()
    
    private init() {}
    
    enum Error: Swift.Error {
        case connectionError
        case failureStatusCode
    }
    
    func request(_ target: TargetType, completion: @escaping(Result<Moya.Response, Swift.Error>) -> Void) {
        provider.request(.target(target)) { result in
            switch result {
            case .success(let response):
                do {
                    let filteredResponse = try response.filterSuccessfulStatusCodes()
                    completion(.success(filteredResponse))
                } catch  {
                    completion(.failure(Error.failureStatusCode))
                }
            case .failure:
                completion(.failure(Error.connectionError))
            }
        }
    }
}
