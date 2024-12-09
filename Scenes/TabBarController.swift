//
//  TabBarController.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 17.09.2024.
//

import UIKit

fileprivate enum Tab {
    case movie
    case tvShow
    case categories
    case search
    case watchList
    
    var tabBarItem: UITabBarItem {
        switch self {
        case .movie:
            UITabBarItem(title: "Movie", image: UIImage(systemName: "movieclapper"), tag: 0)
        case .tvShow:
            UITabBarItem(title: "Tv Show", image: UIImage(systemName: "play.tv"), tag: 1)
        case .categories:
           UITabBarItem(title: "Category", image: UIImage(systemName: "square.grid.2x2.fill"), tag: 2)
        case .search:
            UITabBarItem(title: "Search", image: UIImage(systemName: "sparkle.magnifyingglass"), tag: 3)
        case .watchList:
            UITabBarItem(title: "Watch List", image: UIImage(systemName: "list.and.film"), tag: 4)
        }
    }
    
    var title: String {
        switch self {
        case .movie:
            "Movies"
        case .tvShow:
            "Tv Show"
        case .categories:
            "Categories"
        case .search:
            "Search"
        case .watchList:
            "Watch List"
        }
    }
}

final class TabBarController: UITabBarController {
    
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
        movieVC.title = Tab.movie.title
        movieVC.tabBarItem = Tab.movie.tabBarItem
        return UINavigationController(rootViewController: movieVC)
    }
    
    func createTvShowNC() -> UINavigationController {
        let tvShowVC = TvShowViewController()
        tvShowVC.title = Tab.tvShow.title
        tvShowVC.tabBarItem = Tab.tvShow.tabBarItem
        return UINavigationController(rootViewController: tvShowVC)
    }
    
    func createCategoryNC() -> UINavigationController {
        let categoryVC = GenreFactory.makeGenreFactory()
        categoryVC.title = Tab.categories.title
        categoryVC.tabBarItem = Tab.categories.tabBarItem
        return UINavigationController(rootViewController: categoryVC)
    }
    
    func createSearchNC() -> UINavigationController {
        let searchVC = TrendViewController()
        searchVC.title = Tab.search.title
        searchVC.tabBarItem = Tab.search.tabBarItem
        return UINavigationController(rootViewController: searchVC)
    }
    
    func createWatchListNC() -> UINavigationController {
        let watchListVC = WatchListViewController()
        watchListVC.title = Tab.watchList.title
        watchListVC.tabBarItem = Tab.watchList.tabBarItem
        return UINavigationController(rootViewController: watchListVC)
    }
}
