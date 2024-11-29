//
//  WatchListDataBase.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 5.11.2024.
//

import Foundation

final class WatchListStore {
    private(set) var mediaList: [StoreableMedia] = []
    
    static let shared = WatchListStore()
    private let storeKey: String = "WatchlistStoreKey"
    private let defaults = UserDefaults.standard
    
    private init() {
        retrieveSavedMedia()
    }
    
    func updateMedia(_ media: StoreableMedia) {
        if mediaList.contains(where: { $0.id == media.id }) {
            mediaList.removeAll { $0.id == media.id }
        } else {
            mediaList.append(media)
        }
        
        saveMedia()
    }
    
    func isMediaSaved(id: Int) -> Bool {
        mediaList.contains(where: { $0.id == id })
    }
}

private extension WatchListStore {
    func retrieveSavedMedia() {
        guard let data = defaults.data(forKey: storeKey),
              let storeableMedia = try? JSONDecoder().decode([StoreableMedia].self, from: data) else { return }
        
        self.mediaList = storeableMedia
    }
    
    func saveMedia() {
        if let encodedData = try? JSONEncoder().encode(mediaList) {
            defaults.set(encodedData,forKey: storeKey)
        }
    }
}

extension MovieDetailModel {
    var storeableMedia: StoreableMedia {
        StoreableMedia(id: id, title: title, posterPath: posterPath, type: .movie, release_date: releaseDate)
    }
}

extension TVShowDetailModel {
    var storeableMedia: StoreableMedia {
        StoreableMedia(id: id, title: name, posterPath: posterPath, type: .tv, release_date: firstAirDate)
    }
}
