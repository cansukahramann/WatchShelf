//
//  WatchListDataBase.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 5.11.2024.
//

import Foundation

final class WatchListStore {
    static let shared = WatchListStore()
    private(set) var mediaList: [StoreableMedia] = []
    private let storeKey: String = "WatchlistStoreKey"
    
    private let fileManager = FileManager.default
    private lazy var storeURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0].appending(path: "WatchList.store")
    
    private init() {
        fetchStoredWatchListFromDisk()
    }
    
    private func fetchStoredWatchListFromDisk() {
        guard
            let data = try? Data(contentsOf: storeURL),
            let mediaList = try? JSONDecoder().decode([StoreableMedia].self, from: data) else { return }
        
        self.mediaList = mediaList
    }
    
    func isMediaSaved(id: Int) -> Bool {
        mediaList.contains(where: { $0.id == id })
    }
}

extension WatchListStore {
    func updateMediaInWatchList(_ media: StoreableMedia) {
        if mediaList.contains(where: { $0.id == media.id }) {
            mediaList.removeAll { $0.id == media.id }
        } else {
            mediaList.append(media)
        }
        saveWatchListToDisk()
    }
}

private extension WatchListStore {
    func saveWatchListToDisk() {
        guard let data = try? JSONEncoder().encode(mediaList) else { return }
        try? data.write(to: storeURL)
    }
}

extension MovieDetailModel {
    var storeableMedia: StoreableMedia {
        StoreableMedia(id: id, title: title, posterPath: posterPath, type: .movie, releaseDate: releaseDate)
    }
}

extension TVShowDetails {
    var storeableMedia: StoreableMedia {
        StoreableMedia(id: id, title: name, posterPath: posterPath, type: .tv, releaseDate: firstAirDate)
    }
}
