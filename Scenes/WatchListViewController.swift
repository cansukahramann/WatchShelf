//
//  WatchListViewController.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 17.09.2024.
//

import UIKit
import Lottie

class WatchListViewController: UIViewController {
    
    private var tableView: UITableView = {
        var tableView = UITableView()
        tableView.register(SearchCell.self, forCellReuseIdentifier: "SearchCell")
        tableView.separatorStyle = .singleLine
        tableView.backgroundColor = .systemBackground
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private var emptyStateAnimationView: LottieAnimationView = {
        let animationView = LottieAnimationView(name: "empty_watchlist_animation")
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.animationSpeed = 1.0
        return animationView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        tableView.dataSource = self
        tableView.delegate = self
        checkEmptyState()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        checkEmptyState()
    }
    
    private func setupUI() {
        view.addSubview(tableView)
        view.addSubview(emptyStateAnimationView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            emptyStateAnimationView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emptyStateAnimationView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            emptyStateAnimationView.widthAnchor.constraint(equalToConstant: 300),
            emptyStateAnimationView.heightAnchor.constraint(equalToConstant: 300)
        ])
    }
    private func checkEmptyState() {
        if WatchListStore.shared.mediaList.isEmpty {
            emptyStateAnimationView.isHidden = false
            tableView.isHidden = true
            emptyStateAnimationView.play()
        } else {
            emptyStateAnimationView.isHidden = true
            tableView.isHidden = false
        
        }
    }
}

extension WatchListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        WatchListStore.shared.mediaList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell", for: indexPath) as! SearchCell
        let model = WatchListStore.shared.mediaList[indexPath.row]
        cell.config(model: model)
        return cell
    }
}

extension WatchListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedMedia = WatchListStore.shared.mediaList[indexPath.row]
        
        if selectedMedia.type == .movie {
            let movieDetailVC = MovieDetailViewController(movieID: selectedMedia.id)
            navigationController?.pushViewController(movieDetailVC, animated: true)
        } else if selectedMedia.type == .tv {
            let tvDetailVC = TVShowDetailViewController(tvShowID: selectedMedia.id)
            navigationController?.pushViewController(tvDetailVC, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] (_, _, completionHandler) in
            guard let self = self else { return }
            let mediaToRemove = WatchListStore.shared.mediaList[indexPath.row]
            WatchListStore.shared.updateMedia(mediaToRemove)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            self.checkEmptyState()
            
            let alert = UIAlertController(title: "Removed", message: "This item has been removed from your WatchList.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
            completionHandler(true)
        }
        
        deleteAction.backgroundColor = .red
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        configuration.performsFirstActionWithFullSwipe = true
        return configuration
    }
}
