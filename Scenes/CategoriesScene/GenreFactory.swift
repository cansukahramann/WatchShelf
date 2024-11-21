//
//  GenreFactory.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 21.11.2024.
//

import UIKit

enum GenreFactory {
    static func makeGenreFactory() -> UIViewController {
        let service = GenreService()
        let viewModel = GenreViewModel(service: service)
        let viewController = GenreViewController(viewModel: viewModel)
        return viewController
    }
}
