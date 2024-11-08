//
//  MovieDetailViewController.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 22.09.2024.
//

import UIKit


final class MovieDetailViewController: UIViewController, MovieDetailViewModelDelegate, SimilarMoviesViewDelegate, CastViewDelegate {
    
    private let headerView = DetailHeaderView(frame: .zero)
    private let descriptionView = DescriptionView(frame: .zero)
    private let videoView = VideoView(frame: .zero)
    private let similarMoviesView = SimilarMoviesView(frame: .zero)
    private let castView = MovieCastView(frame: .zero)
    
    private var viewModel: MovieDetailViewModel!
    
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
        viewModel = MovieDetailViewModel(movieID: movieID)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
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
    
    func configureUI() {
        view.backgroundColor = .systemBackground
    }
    
    private func setRightBarButtonItem(with image: UIImage) {
        let rightBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(addButtonTapped))
        rightBarButtonItem.tintColor = UIColor(named: "app_color")
        navigationItem.setRightBarButton(rightBarButtonItem, animated: true)
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
        let detailVC = MovieDetailViewController(movieID: movieID)
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func movieCastSelected(castID: Int) {
        let castDetailVC = CastDetailViewController(castID: castID)
        navigationController?.pushViewController(castDetailVC, animated: true)
    }
    
    func didFetchDetail() {
        setRightBarButtonItem(with: viewModel.isFavorite ? .checkmark : .add)
        headerView.configure(model: viewModel.detailModel)
        descriptionView.configure(text: viewModel.detailModel.overview)
        similarMoviesView.updateSimilarMovie(model: viewModel.similarModel)
        castView.updateCastView(model: viewModel.movieCastModel)
        videoView.getVideo(model: viewModel.movieVideoModel)
    }
    
    @objc
    func addButtonTapped() {
        WatchListStore.shared.updateMedia(viewModel.detailModel.storeableMedia)
        showAlert(message: viewModel.favoriteStatusChangeMessage)
        setRightBarButtonItem(with: viewModel.isFavorite ? .checkmark : .add)
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        self.present(alert, animated: true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            alert.dismiss(animated: true)
        }
    }
}
