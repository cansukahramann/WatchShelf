//
//  DetailViewController.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 22.09.2024.
//

import UIKit


class DetailViewController: UIViewController, DetailViewModelDelegate, SimilarMoviesViewDelegate, CastViewDelegate {
    
    private let headerView = DetailHeaderView(frame: .zero)
    private let descriptionView = DescriptionView(frame: .zero)
    private let videoView = VideoView(frame: .zero)
    private let similarMoviesView = SimilarMoviesView(frame: .zero)
    private let castView = MovieCastView(frame: .zero)
    
    private var viewModel: DetailViewModel!
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .systemBackground
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 18
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    convenience init(movieID: Int) {
        self.init(nibName: nil, bundle: nil)
        viewModel = DetailViewModel(movieID: movieID)
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
        viewModel.fetchDetail()
        viewModel.delegate = self
        similarMoviesView.delegate = self
        castView.delegate = self
    }
    
    private func setupView() {
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        
        
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
    
    func movieCastSelected(castID: Int) {
        let castDetailVC = CastDetailViewController(castID: castID)
        navigationController?.pushViewController(castDetailVC, animated: true)
    }
    
    func didFetchDetail() {
        headerView.configure(model: viewModel.detailModel)
        descriptionView.configure(text: viewModel.detailModel.overview)
        
        similarMoviesView.updateSimilarMovie(model: viewModel.similarModel)
        
        castView.updateCastView(model: viewModel.movieCastModel)
        
        videoView.getVideo(model: viewModel.movieVideoModel)
    }
}
