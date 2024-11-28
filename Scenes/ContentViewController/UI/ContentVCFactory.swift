//
//  ContentVCFactory.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 25.11.2024.
//

import UIKit

enum ContentVCFactory {
    static func makePopularContentVC(onItemSelection: @escaping (Int) -> Void) -> UIViewController {
        makeContentVC(with: "Popular", service: PopularContentService(), onItemSelection: onItemSelection)
    }

    static func makeNowPlayingContentVC(onItemSelection: @escaping (Int) -> Void) -> UIViewController {
        makeContentVC(with: "Now Playing", service: NowPlayingContentService(), onItemSelection: onItemSelection)
    }
    
    static func makeUpcomingContentVC(onItemSelection: @escaping (Int) -> Void) -> UIViewController {
        makeContentVC(with: "Upcoming", service: UpcomingContentService(), onItemSelection: onItemSelection)
    }
    
    static func makeTopRatedContentVC(onItemSelection: @escaping (Int) -> Void) -> UIViewController {
        makeContentVC(with: "Top Rated", service: TopRatedContentService(), onItemSelection: onItemSelection)
    }
    
    static func makeAiringTodayTVContentVC(onItemSelection: @escaping (Int) -> Void) -> UIViewController {
        makeContentVC(with: "Airing Today", service: AiringTodayContentService(), onItemSelection: onItemSelection)
    }
    
    static func makeOnTheAirTVContentVC(onItemSelection: @escaping (Int) -> Void) -> UIViewController {
        makeContentVC(with: "On The Air", service: OnTheAirContentService(), onItemSelection: onItemSelection)
    }
    
    static func makePopularTVContentVC(onItemSelection: @escaping (Int) -> Void) -> UIViewController {
        makeContentVC(with: "Popular", service: PopularTVContentService(), onItemSelection: onItemSelection)
    }
    
    static func makeTopRatedTVContentVC(onItemSelection: @escaping (Int) -> Void) -> UIViewController {
        makeContentVC(with: "Top Rated", service: TopRatedTVContentService(), onItemSelection: onItemSelection)
    }
    
    private static func makeContentVC(with title: String, service: ContentServiceProtocol, onItemSelection: @escaping (Int) -> Void) -> UIViewController {
        let viewModel = ContentViewModel(service: service)
        let viewController = ContentViewController(title: title, viewModel: viewModel)
        viewController.didSelectItem = onItemSelection
        return viewController
    }
}
