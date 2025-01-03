//
//  CastDetailViewController.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 20.10.2024.
//

import UIKit

final class CastDetailViewController: UIViewController, CastMovieCreditsDelegate, CastTVCreditsDelegate, CastDetailViewModelDelegate{
    
    private let headerView = DetailHeaderView()
    private let descriptionView = ExpandableDescriptionView()
    private let castMovieCredits = CastMovieCredits()
    private let castTVCredits = CastTVCredits()
    
    private var viewModel: CastDetailViewModel!
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        castMovieCredits.delegate = self
        castTVCredits.delegate = self
        viewModel.delegate = self
        setupConstraints()
        configureUI()
        viewModel.fetchCastDetail()
    }
    
    convenience init(viewModel: CastDetailViewModel) {
        self.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    func configureUI() {
        stackView.addArrangedSubviews(headerView, descriptionView, castMovieCredits, castTVCredits)
    }
    
    func didFetchCastDetail() {
        headerView.configureCastDetail(model: viewModel.castDetailModel)
        descriptionView.configure(text: viewModel.castDetailModel.biography ?? "N/A")
        castMovieCredits.updateCreditsMovie(model: viewModel.movies)
        castTVCredits.updateTVCredits(model: viewModel.tvShows)
        
        descriptionView.isHidden = viewModel.castDetailModel.biography!.isEmpty
        castMovieCredits.isHidden = viewModel.movies.isEmpty
        castTVCredits.isHidden = viewModel.tvShows.isEmpty
    }
    
    func movieCreditsSelected(movieID: Int) {
        let detailVC = MovieDetailFactory.makeCastDetailVC(movieID: movieID)
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func selectedTVCredits(tvID: Int) {
        let detailVC = TVShowDetailFactory.makeCastDetailViewController(tvShowID: tvID)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
