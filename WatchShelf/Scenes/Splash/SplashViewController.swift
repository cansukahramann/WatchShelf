//
//  SplashViewController.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 7.11.2024.
//

import UIKit

final class SplashViewController: UIViewController {
    private let posterImageNames: [String] = [
        "SplashImages/poster1", "SplashImages/poster2", "SplashImages/poster3", "SplashImages/poster4",
        "SplashImages/poster5", "SplashImages/poster6", "SplashImages/poster7", "SplashImages/poster8",
        "SplashImages/poster9", "SplashImages/poster10", "SplashImages/poster11", "SplashImages/poster12",
        "SplashImages/poster13", "SplashImages/poster14", "SplashImages/poster15", "SplashImages/poster16",
        "SplashImages/poster17", "SplashImages/poster18", "SplashImages/poster19", "SplashImages/poster20",
        "SplashImages/poster21", "SplashImages/poster22", "SplashImages/poster23", "SplashImages/poster24",
        "SplashImages/poster25", "SplashImages/poster26", "SplashImages/poster27", "SplashImages/poster28",
        "SplashImages/poster29", "SplashImages/poster30"
    ]
    
    private var imageViews: [UIImageView] = []
    private let animationDuration: TimeInterval = 4.0
    
    private let columns = 5
    private let rows = 4
    private let spacing: CGFloat = 10
    
    private let animationGroup = DispatchGroup()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.setNavigationBarHidden(true, animated: true)
        view.backgroundColor = .black
        
        setupPosterImages()
        
        animationGroup.notify(queue: .main) { [self] in
            pushToTabBarController()
        }
    }
    
    private func rowHeight() -> CGFloat {
        view.bounds.height / CGFloat(rows)
    }
    
    private func columnWidth() -> CGFloat {
        rowHeight() * 3 / 4
    }
    
    private func setupPosterImages() {
        let rowHeight = rowHeight()
        let columnWidth = columnWidth()
        let posterSize = CGSize(width: columnWidth - spacing, height: rowHeight - spacing)
        
        for row in 0..<rows {
            for column in 0..<columns {
                let index = row * columns + column
                guard index < posterImageNames.count, let image = UIImage(named: posterImageNames[index % posterImageNames.count]) else { continue }
                
                let xPosition: CGFloat = CGFloat(column) * columnWidth
                let yPosition = CGFloat(row) * rowHeight
                
                let imageView = UIImageView(image: image)
                imageView.frame = CGRect(
                    x: xPosition,
                    y: yPosition,
                    width: posterSize.width,
                    height: posterSize.height
                )
                imageView.contentMode = .scaleAspectFill
                imageView.layer.cornerRadius = 8
                imageView.clipsToBounds = true
                imageView.alpha = 0
                imageViews.append(imageView)
                view.addSubview(imageView)
                startPosterAnimation(for: imageView, row: row)
            }
        }
    }
    
    private func startPosterAnimation(for imageView: UIImageView, row: Int) {
        animationGroup.enter()
        let totalWidth = CGFloat(columns) * columnWidth()
        let availableWidthToScroll = totalWidth - view.bounds.width
        let direction: CGFloat = (row % 2 == 0) ? -1 : 1
        
        if !row.isMultiple(of: 2) {
            imageView.frame.origin.x -= availableWidthToScroll
        }
        
        UIView.animate(withDuration: 1) {
            imageView.alpha = 1
        }
        
        UIView.animate(withDuration: animationDuration, delay: 0.5, options: [.curveEaseInOut]) {
            imageView.frame.origin.x += direction * availableWidthToScroll
        } completion: { _ in
            self.animationGroup.leave()
        }
    }
    
    func pushToTabBarController() {
        if let navigationController = self.navigationController {
            let tabBarController = TabBarController()
            navigationController.pushViewController(tabBarController, animated: true)
        }
    }
}
