//
//  TVShowDetailFactory.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 20.11.2024.
//

import UIKit

enum TVShowDetailFactory {
    static func makeCastDetailViewController(tvShowID: Int) -> UIViewController {
        let service = TVShowDetailService(tvShowID: tvShowID)
        let viewModel = TVShowDetailViewModel(service: service, tvShowID: tvShowID)
        let viewController = TVShowDetailViewController(viewModel: viewModel)
        return viewController
    }
}
