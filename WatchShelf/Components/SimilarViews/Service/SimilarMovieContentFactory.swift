//
//  SimilarMovieContentFactory.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 2.12.2024.
//

import UIKit

enum SimilarMovieContentFactory {
    static func makeView(with id: Int, onItemSelection: @escaping (Int) -> Void) -> UIView {
        let service = SimilarMovieService()
        let viewModel = SimilarContentViewModel(service: service, similarID: id)
        let view = SimilarContentView(viewModel: viewModel)
        view.didSelectItem = onItemSelection
        return view
    }
}
