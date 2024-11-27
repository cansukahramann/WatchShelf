//
//  UIHelper.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 19.09.2024.
//

import UIKit
import ProgressHUD

enum UIHelper {
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
    
    static func showHUD() {
        ProgressHUD.animate(symbol: "movieclapper",interaction: false)
        ProgressHUD.colorAnimation = .white
        ProgressHUD.colorHUD = .lightText
        ProgressHUD.colorHUD = .clear
        
        
    }

    static func dismissHUD(delay: CGFloat = 0.0) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            ProgressHUD.dismiss()
        }
    }
    
    static func showHUDerrorMessage() {
        ProgressHUD.succeed("Something went wrong")
        ProgressHUD.colorAnimation = .white
        ProgressHUD.colorHUD = .lightText
    }
}
