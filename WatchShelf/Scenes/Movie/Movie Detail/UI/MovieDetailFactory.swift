//
//  MovieDetailFactory.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 20.11.2024.
//

import UIKit

enum MovieDetailFactory {
    static func makeCastDetailVC(movieID: Int) -> UIViewController {
        let service = MovieDetailService(movieID: movieID)
        let viewModel = MovieDetailViewModel(service: service, movieID: movieID)
        let viewController = MovieDetailViewController(viewModel: viewModel)
        return viewController
    }
}
