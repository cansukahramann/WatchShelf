//
//  CastDetailService.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 13.11.2024.
//

import Foundation
import Moya

final class CastDetailService {
    private let group = DispatchGroup()
    
    private var castDetail: CastDetailResponse!
    private var movieCredits = [CastCredit]()
    private var tvCredits = [CastCredit]()
    private var castID: Int
    
    init(castID: Int) {
        self.castID = castID
    }
    
    func loadCastDetail(completion: @escaping(Result<(CastDetailResponse, [CastCredit], [CastCredit]), Error>) -> Void) {
        loadPeopleDetail()
        loadPeopleMovieCredits()
        loadPeopleTVCredits()
       
        group.notify(queue: .main) { [weak self] in
            guard let self else { return }
            if let castDetail = castDetail {
                completion(.success((castDetail, movieCredits, tvCredits)))
            } else {
                let error = NSError(domain: "CastDetailService", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to load cast details"])
                completion(.failure(error))
            }
        }
    }
    
    private func loadPeopleDetail() {
        group.enter()
        NetworkManager.shared.request(DetailAPI.peopleDetail(castID: castID)) { [weak self] result in
            guard let self else { return }
            let mappingResult: Result<CastDetailResponse, PresentableError> = ResponseMapper.map(result)
            if let mappedCastDetail = try? mappingResult.get() {
                castDetail = mappedCastDetail
            }
            group.leave()
        }
    }
    
    private func loadPeopleMovieCredits() {
        group.enter()
        NetworkManager.shared.request(DetailAPI.peopleMovieCredits(castID: castID)) { [weak self] result in
            guard let self else { return }
            let mappingResult: Result<CastCredits, PresentableError> = ResponseMapper.map(result)
            if let mappedMovieCredits = try? mappingResult.get() {
                movieCredits = mappedMovieCredits.cast
            }
            group.leave()
        }
    }

    private func loadPeopleTVCredits()  {
        group.enter()
        NetworkManager.shared.request(DetailAPI.peopleTVCredits(castID: castID)) { [weak self] result in
            guard let self else { return }
            let mappingResult: Result<CastCredits, PresentableError> = ResponseMapper.map(result)
            if let mappedTVCredits = try? mappingResult.get() {
                tvCredits = mappedTVCredits.cast
            }
            group.leave()
        }
    }
}
