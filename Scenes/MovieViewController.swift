//
//  MovieViewController.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 17.09.2024.
//

import UIKit
import Moya

class MovieViewController: UIViewController {
    
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
        
        let configurations: [(title: String, contentAPI: ContentAPI)] = [
            ("Popular", .popularMovie),
            ("Now Playing",.nowPlayingMovie),
            ("Upcoming", .upcomingMovie),
            ("Top Rated", .topRatedMovie)
        ]
        
        for configuration in configurations {
            let contentVC = ContentViewController(title: configuration.title, contentAPI: configuration.contentAPI)
            contentVC.didSelectItem = { [weak navigationController] id in
                let viewController = DetailViewController(movieID: id)
                navigationController?.pushViewController(viewController, animated: true)
            }
            
            addChild(contentVC)
            stackView.addArrangedSubview(contentVC.view)
            contentVC.didMove(toParent: self)
        }
        
        setUpUI()
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
