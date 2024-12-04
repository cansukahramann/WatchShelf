//
//  CategoryDetailFactory.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 21.11.2024.
//

import UIKit

enum CategoryDetailFactory {
    static func makeCategoryDetailVC(genreID: Int) -> UIViewController {
        let service = CategoryDetailService(genreID: genreID)
        let viewModel = CategoryDetailViewModel(service: service, genreID: genreID)
        let viewController = CategoryDetailViewController(viewModel: viewModel)
        return viewController
    }
}
