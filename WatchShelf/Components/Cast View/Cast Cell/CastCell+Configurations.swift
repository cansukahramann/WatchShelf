//
//  CastCell+Configurations.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 2.01.2025.
//

import UIKit

extension CastCell {
    func configureViews() {
        castRealName.setContentCompressionResistancePriority(.required, for: .vertical)
        castMovieName.setContentCompressionResistancePriority(.required, for: .vertical)
    }
}
