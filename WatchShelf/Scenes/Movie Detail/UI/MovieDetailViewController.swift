//
//  MovieDetailViewController.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 22.09.2024.
//

import UIKit

final class MovieDetailViewController: UIViewController, MovieDetailViewModelDelegate, SimilarMoviesViewDelegate {
    private let headerView = DetailHeaderView()
    private let descriptionView = DescriptionView()
    private let videoView = VideoView()
    private let castView = CastView()
    
    private var viewModel: MovieDetailViewModel!
    private var similarMoviesView: SimilarMoviesView!
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .systemBackground
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 18
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    convenience init(viewModel: MovieDetailViewModel) {
        self.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchMovieDetail()
        viewModel.delegate = self
        setupConstraints()
        configureUI()
        similarView()
        similarMoviesView.delegate = self
        
        castView.onCastSelection = { [unowned self] id in
            let vc = CastDetailFactory.makeCastDetailVC(castID: id)
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    private func similarView() {
        let similarMoviesView = SimilarMovieContentFactory.makeView(with: viewModel.movieID) { movieID in
            self.similarMovieSelected(movieID: movieID)
        }
        self.similarMoviesView = similarMoviesView as? SimilarMoviesView
        stackView.addArrangedSubview(similarMoviesView)
    }
    
    private func configureUI() {
        view.backgroundColor = .systemBackground
        stackView.addArrangedSubviews(headerView, descriptionView, videoView, castView)
        
        NSLayoutConstraint.activate([
            videoView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    private func setRightBarButtonItem(with image: UIImage) {
        let rightBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(addButtonTapped))
        image.withTintColor(.black)
        rightBarButtonItem.tintColor = .white
        navigationItem.setRightBarButton(rightBarButtonItem, animated: true)
    }
        
    func similarMovieSelected(movieID: Int) {
        let detailVC = MovieDetailFactory.makeCastDetailVC(movieID: movieID)
        navigationController?.pushViewController(detailVC, animated: true)
    }
        
    func didFetchDetail() {
        setRightBarButtonItem(with: viewModel.isFavorite ? .checkmark.withTintColor(.gray) : .add)
        headerView.configure(model: viewModel.detailModel)
        descriptionView.configure(text: viewModel.detailModel.overview)
        castView.casts = viewModel.casts
        videoView.getVideo(model: viewModel.movieVideoModel)
    
        castView.isHidden = viewModel.casts.isEmpty
        videoView.isHidden = viewModel.movieVideoModel.isEmpty
        similarMoviesView.hiddenIfNoData()
    }
    
    @objc
    private func addButtonTapped() {
        WatchListStore.shared.updateMediaInWatchList(viewModel.detailModel.storeableMedia)
        showAlert(message: viewModel.favoriteStatusChangeMessage)
        setRightBarButtonItem(with: viewModel.isFavorite ? .checkmark.withTintColor(.gray) : .add)
        
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        self.present(alert, animated: true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            alert.dismiss(animated: true)
        }
    }
}
