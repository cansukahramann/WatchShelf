//
//  DetailViewController.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 22.09.2024.
//

import UIKit
import Kingfisher

class DetailViewController: UIViewController, DetailViewModelDelegate, SimilarMoviesViewDelegate {
   
    private let headerView = DetailHeaderView(frame: .zero)
    private let descriptionView = DescriptionView(frame: .zero)
    private let videoView = VideoView(frame: .zero)
    private let similarMoviesView = SimilarMoviesView(frame: .zero)
    private let castView = CastView(frame: .zero)
    
    private var detailViewModel: DetailViewModel!
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .systemBackground
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 36
        return stackView
    }()
    
    convenience init(movieID: Int) {
        self.init(nibName: nil, bundle: nil)
        detailViewModel = DetailViewModel(movieID: movieID)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupView()
        configureDetailHeaderView()
        configureDescriptionView()
        configureVideoView()
        configureCastView()
        configureCollectionView()
        detailViewModel.fetchDetail()
        detailViewModel.delegate = self
        similarMoviesView.delegate = self
        
    }
    
    private func setupView() {
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate( [
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }
    
    private func configureDetailHeaderView() {
        stackView.addArrangedSubview(headerView)
    }
    
    private func configureDescriptionView() {
        stackView.addArrangedSubview(descriptionView)
    }
    
    private func configureVideoView() {
        stackView.addArrangedSubview(videoView)
        
        NSLayoutConstraint.activate([
            videoView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    private func configureCollectionView() {
        stackView.addArrangedSubview(similarMoviesView)
    }
    
    private func configureCastView() {
        stackView.addArrangedSubview(castView)
    }
    
    func similarMovieSelected(movieID: Int) {
        let detailVC = DetailViewController(movieID: movieID)
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func didFetchDetail() {
        headerView.configure(model: detailViewModel.detailModel)
        descriptionView.configure(text: detailViewModel.detailModel.overview)
    
        similarMoviesView.updateSimilarMovie(model: detailViewModel.similarModel)
        
        castView.updateCastView(model: detailViewModel.movieCastModel)
        
        videoView.getVideo(model: detailViewModel.movieVideoModel)
    }
}
