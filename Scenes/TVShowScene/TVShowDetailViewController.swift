//
//  TVShowDetailViewController.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 25.10.2024.
//

import UIKit


class TVShowDetailViewController: UIViewController, TVShowDetailViewModelDelegate,TVShowCastViewDelegate, SimilarTVShowViewDelegate {
  
    private let headerView = DetailHeaderView(frame: .zero)
    private let descriptionView = DescriptionView(frame: .zero)
    private let videoView = VideoView(frame: .zero)
    private let castView = TVShowCastView(frame: .zero)
    private let similarView = SimilarTVShowView(frame: .zero)
    
    private var viewModel: TVShowDetailViewModel!
    

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
    
    convenience init(tvShowID: Int) {
        self.init(nibName: nil, bundle: nil)
        viewModel = TVShowDetailViewModel(tvShowID: tvShowID)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .purple
        setupUI()
        configureUI()
        viewModel.fetchTVDetail()
        viewModel.delegate = self
        castView.delegate = self
        similarView.delegate = self
        
    }
    
    private func setupUI() {
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
    
    private func configureUI() {
        stackView.addArrangedSubview(headerView)
        stackView.addArrangedSubview(descriptionView)
        stackView.addArrangedSubview(videoView)
        NSLayoutConstraint.activate([
            videoView.heightAnchor.constraint(equalToConstant: 200)
        ])
        stackView.addArrangedSubview(castView)
        if viewModel.tvSimilarModel.isEmpty {
            stackView.removeArrangedSubview(similarView)
        } else {
            stackView.addArrangedSubview(similarView)
        }
    }
    
    func didFetchDetail() {
        headerView.configureTVDetail(model: viewModel.model)
        descriptionView.configure(text: viewModel.model.overview)
        videoView.getTVVideo(model: viewModel.tvVideoModel)
        castView.updateCastView(model: viewModel.tvCastModel)
        similarView.updateSimilarTVShow(model: viewModel.tvSimilarModel)
    }
    
    func tvCastSelected(castID: Int) {
        let castDetailVC = CastDetailViewController(castID: castID)
        navigationController?.pushViewController(castDetailVC, animated: true)
    }
    
    func similarTVShowSelected(tvShowID: Int) {
        let tvShowDetail = TVShowDetailViewController(tvShowID: tvShowID)
        navigationController?.pushViewController(tvShowDetail, animated: true)
    }
   
}
