//
//  TVShowDetailFactory.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 20.11.2024.
//

import UIKit

enum TVShowDetailFactory {
    static func makeCastDetailVC(seriesID: Int) -> UIViewController {
        let service = TVShowDetailService()
        let viewModel = TVShowDetailViewModel(service: service, seriesID: seriesID)
        let viewController = TVShowDetailViewController(viewModel: viewModel)
        return viewController
    }
}
