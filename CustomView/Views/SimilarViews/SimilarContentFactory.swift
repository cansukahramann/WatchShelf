//
//  SimilarContentFactory.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 2.12.2024.
//

import UIKit

enum SimilarContentFactory {
   static func makeView(with id: Int, service: SimilarServiceProtocol, onItemSelection: @escaping (Int) -> Void) -> UIView {
        let viewModel = SimilarMovieViewModel(service: service,movieID: id)
        let view = SimilarMoviesView(viewModel: viewModel)
        view.didSelectItem = onItemSelection
       print("View created: \(view)")
        return view
    }
}
