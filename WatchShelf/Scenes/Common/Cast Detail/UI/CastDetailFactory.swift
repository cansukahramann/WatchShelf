//
//  CastDetailFactory.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 20.11.2024.
//

import UIKit

enum CastDetailFactory {
    static func makeCastDetailVC(castID: Int) -> UIViewController {
        let service = CastDetailService(castID: castID)
        let viewModel = CastDetailViewModel(service: service, castID: castID)
        let viewController = CastDetailViewController(viewModel: viewModel)
        return viewController
    }
}
