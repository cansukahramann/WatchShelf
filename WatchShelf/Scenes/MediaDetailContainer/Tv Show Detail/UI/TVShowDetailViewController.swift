//
//  TVShowDetailViewController.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 25.10.2024.
//

import UIKit

final class TVShowDetailViewController: UIViewController, TVShowDetailViewModelDelegate, BaseSimilarViewDelegate {
   
    private let headerView = DetailHeaderView()
    private let descriptionView = ExpandableDescriptionView()
    private let videoView = VideoView()
    private let castView = CastView()
    private var viewModel: TVShowDetailViewModel!
    
    private var similarContentView: SimilarContentView!
    
    
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
    
    convenience init(viewModel: TVShowDetailViewModel) {
        self.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .purple
        setupConstraints()
        configureUI()
        viewModel.fetchTVShowDetail()
        viewModel.delegate = self
        similarTVShowView()
        similarContentView.delegate = self
        
        castView.onCastSelection = { [unowned self] id in
            let castDetailVC = CastDetailFactory.makeCastDetailVC(castID: id)
            navigationController?.pushViewController(castDetailVC, animated: true)
        }
    }
    
    private func similarTVShowView() {
        let similarView = SimilarTVShowContentFactory.makeView(with: viewModel.tvShowID) { tvShowID in
            self.similarContentSelected(similarID: tvShowID)
        }
        self.similarContentView = similarView as? SimilarContentView
        stackView.addArrangedSubview(similarView)
    }
    
    private func setRightBarButtonItem(with image: UIImage) {
        let rightBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(toggleFavoriteStatus))
        rightBarButtonItem.tintColor = .white
        navigationItem.setRightBarButton(rightBarButtonItem, animated: true)
    }
    
    private func configureUI() {
        stackView.addArrangedSubviews(headerView, descriptionView, videoView, castView)
        
        NSLayoutConstraint.activate([
            videoView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    func didFetchDetail() {
        setRightBarButtonItem(with: viewModel.isFavorite ? .checkmark.withTintColor(.gray) : .add)
        headerView.configureTVDetail(model: viewModel.model)
        descriptionView.configure(text: viewModel.model.overview)
        videoView.getVideo(model: viewModel.tvVideoModel)
        castView.casts = viewModel.casts
        castView.isHidden = viewModel.casts.isEmpty
        videoView.isHidden = viewModel.tvVideoModel.isEmpty
        similarContentView.hiddenIfNoData()
    }
    
    func similarContentSelected(similarID: Int) {
        let tvShowDetail = TVShowDetailFactory.makeCastDetailViewController(tvShowID: similarID)
        navigationController?.pushViewController(tvShowDetail, animated: true)
    }
    
    @objc
    private func toggleFavoriteStatus() {
        WatchListStore.shared.updateMediaInWatchList(viewModel.model.storeableMedia)
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

