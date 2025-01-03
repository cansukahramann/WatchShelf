//
//  BaseMediaViewController.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 3.01.2025.
//

import UIKit

class BaseMediaViewController: UIViewController {
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .systemBackground
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureChildViewControllers()
        setupConstraints()
    }
    
    ///Subclass must implement this method
    func configureChildViewControllers() {}
    
    func addChildViewControllers(_ viewControllers: [UIViewController]) {
        viewControllers.forEach { viewController in
            addChild(viewController)
            stackView.addArrangedSubview(viewController.view)
            viewController.didMove(toParent: self)
        }
    }
}
