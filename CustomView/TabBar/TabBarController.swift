//
//  TabBarController.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 17.09.2024.
//

import UIKit

class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().backgroundColor = .systemBackground
        UITabBar.appearance().tintColor = .red
        viewControllers = [createMovieNC(),createTvShowNC(),createCategoryNC(),createSearchNC(),createWatchListNC()]
    }
    
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
        
        return UINavigationController(rootViewController: tvShowVC
)
    }
    
    func createCategoryNC() -> UINavigationController {
        let categoryVC = CategoriesViewController()
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
