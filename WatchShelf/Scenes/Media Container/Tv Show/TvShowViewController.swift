//
//  TvShowViewController.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 17.09.2024.
//

import UIKit

final class TvShowViewController: BaseMediaViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configureChildViewControllers() {
        let viewControllers: [UIViewController] = [
            HorizontalMediaListingVCFactory.makeAiringTodayContentViewController(onItemSelection: onItemSelection),
            HorizontalMediaListingVCFactory.makeOnTheAirTVContentViewController(onItemSelection: onItemSelection),
            HorizontalMediaListingVCFactory.makePopularTVContentViewController(onItemSelection: onItemSelection),
            HorizontalMediaListingVCFactory.makeTopRatedTVContentViewController(onItemSelection: onItemSelection)
        ]
        
        addChildViewControllers(viewControllers)
    }
    
    private func onItemSelection(id: Int) -> Void {
        let tvShowDetailVC = TVShowDetailFactory.makeCastDetailViewController(tvShowID: id)
        navigationController?.pushViewController(tvShowDetailVC, animated: true)
    }
}

