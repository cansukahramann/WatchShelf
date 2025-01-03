//
//  MovieViewController.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 17.09.2024.
//

import UIKit

final class MovieViewController: BaseMediaViewController {    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configureChildViewControllers() {
        let viewControllers: [UIViewController] = [
            HorizontalMediaListingVCFactory.makePopularContentVC(onItemSelection: onItemSelection(id:)),
            HorizontalMediaListingVCFactory.makeNowPlayingContentVC(onItemSelection: onItemSelection),
            HorizontalMediaListingVCFactory.makeUpcomingContentVC(onItemSelection: onItemSelection),
            HorizontalMediaListingVCFactory.makeTopRatedContentVC(onItemSelection: onItemSelection)
        ]
        
        addChildViewControllers(viewControllers)
    }
    
    private func onItemSelection(id: Int) -> Void {
        let movieDetailVC = MovieDetailFactory.makeCastDetailVC(movieID: id)
        navigationController?.pushViewController(movieDetailVC, animated: true)
    }
}
