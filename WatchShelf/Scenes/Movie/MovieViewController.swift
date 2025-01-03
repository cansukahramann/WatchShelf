//
//  MovieViewController.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 17.09.2024.
//

import UIKit

final class MovieViewController: UIViewController {
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
        configureChildViewControllers()
        setupConstraints()
    }
    
    private func configureChildViewControllers() {
        let viewControllers: [UIViewController] = [
            HorizontalMediaListingVCFactory.makePopularContentVC(onItemSelection: onItemSelection(id:)),
            HorizontalMediaListingVCFactory.makeNowPlayingContentVC(onItemSelection: onItemSelection),
            HorizontalMediaListingVCFactory.makeUpcomingContentVC(onItemSelection: onItemSelection),
            HorizontalMediaListingVCFactory.makeTopRatedContentVC(onItemSelection: onItemSelection)
        ]
        
        viewControllers.forEach { viewController in
            addChild(viewController)
            stackView.addArrangedSubview(viewController.view)
            viewController.didMove(toParent: self)
        }
    }
    
    private func onItemSelection(id: Int) -> Void {
        let movieDetailVC = MovieDetailFactory.makeCastDetailVC(movieID: id)
        navigationController?.pushViewController(movieDetailVC, animated: true)
    }
}
