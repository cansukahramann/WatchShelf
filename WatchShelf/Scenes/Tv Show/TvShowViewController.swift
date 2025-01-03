//
//  TvShowViewController.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 17.09.2024.
//

import UIKit

final class TvShowViewController: UIViewController {
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .systemBackground
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupConstraints()
        addChildViewControllers()
    }
    
    private func addChildViewControllers() {
        let viewControllers: [UIViewController] = [
            HorizontalMediaListingVCFactory.makeAiringTodayContentViewController(onItemSelection: onItemSelection),
            HorizontalMediaListingVCFactory.makeOnTheAirTVContentViewController(onItemSelection: onItemSelection),
            HorizontalMediaListingVCFactory.makePopularTVContentViewController(onItemSelection: onItemSelection),
            HorizontalMediaListingVCFactory.makeTopRatedTVContentViewController(onItemSelection: onItemSelection)
        ]
        
        viewControllers.forEach { viewController in
            addChild(viewController)
            stackView.addArrangedSubview(viewController.view)
            viewController.didMove(toParent: self)
        }
    }
    
    private func onItemSelection(id: Int) -> Void {
        let tvShowDetailVC = TVShowDetailFactory.makeCastDetailViewController(tvShowID: id)
        navigationController?.pushViewController(tvShowDetailVC, animated: true)
    }
}

