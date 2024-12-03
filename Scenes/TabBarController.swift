//
//  TabBarController.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 17.09.2024.
//

import UIKit

final class TabBarController: UITabBarController {
    
    convenience init() {
        self.init(nibName: nil, bundle: nil)
        
        UITabBar.appearance().backgroundColor = .systemBackground
        UITabBar.appearance().tintColor = .app
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewControllers = [
            createMovieNC(),
            createTvShowNC(),
            createCategoryNC(),
            createSearchNC(),
            createWatchListNC()]
    }
}

private extension TabBarController {
    func createMovieNC() -> UINavigationController {
        let movieVC = MovieViewController()
        movieVC.title = "Movies"
        movieVC.tabBarItem = UITabBarItem(title: "Movie", image: UIImage(systemName: "movieclapper"), tag: 0)
        return UINavigationController(rootViewController: movieVC)
    }
    
    func createTvShowNC() -> UINavigationController {
        let tvShowVC = TvShowViewController()
        tvShowVC.title = "Tv Show"
        tvShowVC.tabBarItem = UITabBarItem(title: "Tv Show", image: UIImage(systemName: "play.tv"), tag: 1)
        return UINavigationController(rootViewController: tvShowVC)
    }
    
    func createCategoryNC() -> UINavigationController {
        let categoryVC = GenreFactory.makeGenreFactory()
        categoryVC.title = "Categories"
        categoryVC.tabBarItem = UITabBarItem(title: "Category", image: UIImage(systemName: "square.grid.2x2.fill"), tag: 2)
        return UINavigationController(rootViewController: categoryVC)
    }
    
    func createSearchNC() -> UINavigationController {
        let searchVC = TrendViewController()
        searchVC.title = "Search"
        searchVC.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "sparkle.magnifyingglass"), tag: 3)
        return UINavigationController(rootViewController: searchVC)
    }
    
    func createWatchListNC() -> UINavigationController {
        let watchListVC = WatchListViewController()
        watchListVC.title = "Watch List"
        watchListVC.tabBarItem = UITabBarItem(title: "Watch List", image: UIImage(systemName: "list.and.film"), tag: 4)
        return UINavigationController(rootViewController: watchListVC)
    }
}
