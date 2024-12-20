//
//  NetworkManager.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 3.12.2024.
//

import Foundation
import Moya
import Alamofire

final class NetworkManager {
    static let shared = NetworkManager()
    private let provider = MoyaProvider<MultiTarget>()
    
    private init() {}
    
    enum Error: Swift.Error {
        case connectionError
        case failureStatusCode
    }
    
    @discardableResult
    func request(_ target: TargetType, completion: @escaping (Result<Moya.Response, Swift.Error>) -> Void) -> Cancellable {
        provider.request(.target(target)) { result in
            switch result {
            case .success(let response):
                do {
                    let filteredResponse = try response.filterSuccessfulStatusCodes()
                    completion(.success(filteredResponse))
                } catch  {
                    completion(.failure(Error.failureStatusCode))
                }
            case .failure(let error):
                switch error {
                case .underlying(let error as AFError, _):
                    switch error {
                    case .explicitlyCancelled: break
                    default: completion(.failure(Error.connectionError))
                    }
                default:
                    completion(.failure(Error.connectionError))
                }

            }
        }
    }
}
