//
//  MovieViewController.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 17.09.2024.
//

import UIKit
import Moya

final class MovieViewController: UIViewController {
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .systemBackground
        return scrollView
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureChildViewControllers()
        setUpUI()
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
    
    private func setUpUI() {
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate( [
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }
}
