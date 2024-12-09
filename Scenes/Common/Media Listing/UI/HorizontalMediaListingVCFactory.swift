//
//  HorizontalMediaListingVCFactory.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 25.11.2024.
//

import UIKit

enum HorizontalMediaListingVCFactory {
    static func makePopularContentVC(onItemSelection: @escaping (Int) -> Void) -> UIViewController {
        makeContentVC(with: "Popular", service: PopularMediaService(), onItemSelection: onItemSelection)
    }

    static func makeNowPlayingContentVC(onItemSelection: @escaping (Int) -> Void) -> UIViewController {
        makeContentVC(with: "Now Playing", service: NowPlayingMediaService(), onItemSelection: onItemSelection)
    }
    
    static func makeUpcomingContentVC(onItemSelection: @escaping (Int) -> Void) -> UIViewController {
        makeContentVC(with: "Upcoming", service: UpcomingMediaService(), onItemSelection: onItemSelection)
    }
    
    static func makeTopRatedContentVC(onItemSelection: @escaping (Int) -> Void) -> UIViewController {
        makeContentVC(with: "Top Rated", service: TopRatedMediaService(), onItemSelection: onItemSelection)
    }
    
    static func makeAiringTodayTVContentVC(onItemSelection: @escaping (Int) -> Void) -> UIViewController {
        makeContentVC(with: "Airing Today", service: AiringTodayMediaService(), onItemSelection: onItemSelection)
    }
    
    static func makeOnTheAirTVContentVC(onItemSelection: @escaping (Int) -> Void) -> UIViewController {
        makeContentVC(with: "On The Air", service: OnTheAirMediaService(), onItemSelection: onItemSelection)
    }
    
    static func makePopularTVContentVC(onItemSelection: @escaping (Int) -> Void) -> UIViewController {
        makeContentVC(with: "Popular", service: PopularTVMediaService(), onItemSelection: onItemSelection)
    }
    
    static func makeTopRatedTVContentVC(onItemSelection: @escaping (Int) -> Void) -> UIViewController {
        makeContentVC(with: "Top Rated", service: TopRatedTVMediaService(), onItemSelection: onItemSelection)
    }
    
    private static func makeContentVC(with title: String, service: MediaServiceProtocol, onItemSelection: @escaping (Int) -> Void) -> UIViewController {
        let viewModel = MediaListingViewModel(service: service)
        let viewController = HorizontalMediaListingViewController(title: title, viewModel: viewModel)
        viewController.didSelectItem = onItemSelection
        return viewController
    }
}
