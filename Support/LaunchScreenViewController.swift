//
//  LaunchScreenViewController.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 7.11.2024.
//

import UIKit
import Lottie

class LaunchScreenViewController: UIViewController {
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let animationView = LottieAnimationView(name: "open_animation")
        animationView.frame = CGRect(x: 0, y: 0, width: 400, height: 400)
        animationView.center = self.view.center
        animationView.contentMode = .scaleAspectFit
        view.backgroundColor = .systemBackground
        self.view.addSubview(animationView)
        
        animationView.play {  [weak self] (finished) in
            guard let self else { return }
            if finished {
                let tabBarController = TabBarController()
                if let window = self.view.window {
                    UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve) {
                        self.view.window?.rootViewController = tabBarController
                    }
                }
            }
        }
    }

}
