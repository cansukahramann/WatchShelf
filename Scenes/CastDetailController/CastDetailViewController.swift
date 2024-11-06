//
//  CastDetailViewController.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 20.10.2024.
//

import UIKit


class CastDetailViewController: UIViewController, CastDetailViewModelDelegate, CastMovieCreditsDelegate, CastTVCreditsDelegate{
    
    private let headerView = DetailHeaderView(frame: .zero)
    private let descriptionView = DescriptionView(frame: .zero)
    private let castMovieCredits = CastMovieCredits(frame: .zero)
    private let castTVCredits = CastTVCredits(frame: .zero)
    
    private var viewModel: CastDetailViewModel!
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        configureUI()
        
        viewModel.delegate = self
        viewModel.fetchCastDetail()
        
        castMovieCredits.delegate = self
        castTVCredits.delegate = self
        
    }
    
    convenience init(castID: Int) {
        self.init(nibName: nil, bundle: nil)
        viewModel = CastDetailViewModel(castID: castID)
    }
    
    private func setup() {
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
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
        stackView.addArrangedSubview(headerView)
        stackView.addArrangedSubview(descriptionView)
        stackView.addArrangedSubview(castMovieCredits)
        stackView.addArrangedSubview(castTVCredits)
    }
    
    func didFetchCastDetail() {
        headerView.configureCastDetail(model: viewModel.castDetailModel)
        descriptionView.configure(text: viewModel.castDetailModel.biography ?? "N/A")
        castMovieCredits.updateCreditsMovie(model: viewModel.movies)
        castTVCredits.updateTVCredits(model: viewModel.tvShows)
    }
    
    func movieCreditsSelected(movieID: Int) {
        let detailVC = MovieDetailViewController(movieID: movieID)
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func selectedTVCredits(tvID: Int) {
        let detailVC = TVShowDetailViewController()
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
