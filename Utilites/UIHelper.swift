//
//  UIHelper.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 19.09.2024.
//

import UIKit

struct UIHelper {
    static func twoColumnHorizontalLayout(in collectionView: UIView) -> UICollectionViewFlowLayout {
        let width = collectionView.bounds.width
        let padding: CGFloat = 8
        let minimumItemSpacing: CGFloat = 16
        let availableWidth = width - (padding * 2) - minimumItemSpacing
        let itemWidth = availableWidth / 2
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize = CGSize(width: itemWidth, height: collectionView.bounds.height)
        flowLayout.scrollDirection = .horizontal
        
        return flowLayout
    }
}
