//
//  TVShowDetailViewController.swift
//  WatchShelf
//
//  Created by Cansu Kahraman on 25.10.2024.
//

import UIKit


final class TVShowDetailViewController: UIViewController, TVShowDetailViewModelDelegate,TVShowCastViewDelegate,SimilarTVShowViewDelegate {
    private let headerView = DetailHeaderView()
    private let descriptionView = DescriptionView()
    private let videoView = VideoView()
    private let castView = TVShowCastView()
    
    private var similarView: SimilarTVShowView!
    private var viewModel: TVShowDetailViewModel!
    private var castDetailViewModel: CastDetailViewModel!
    
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
    
    convenience init(viewModel: TVShowDetailViewModel) {
        self.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .purple
        setupUI()
        configureUI()
        viewModel.fetchTVShowDetail()
        viewModel.delegate = self
        similarTVShowView()
        similarView.delegate = self
        castView.delegate = self
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
    
    private func similarTVShowView() {
        let similarView = SimilarTVShowContentFactory.makeView(with: viewModel.tvShowID) { tvShowID in
            self.similarTVShowSelected(tvShowID: tvShowID)
        }
        self.similarView = similarView as? SimilarTVShowView
        stackView.addArrangedSubview(similarView)
    }
    
    private func setRightBarButtonItem(with image: UIImage) {
        let rightBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(addButtonTapped))
        rightBarButtonItem.tintColor = .white
        navigationItem.setRightBarButton(rightBarButtonItem, animated: true)
    }
    
    private func configureUI() {
        stackView.addArrangedSubviews(headerView,descriptionView,videoView,castView)
        
        NSLayoutConstraint.activate([
            videoView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    func didFetchDetail() {
        setRightBarButtonItem(with: viewModel.isFavorite ? .checkmark.withTintColor(.gray) : .add)
        headerView.configureTVDetail(model: viewModel.model)
        descriptionView.configure(text: viewModel.model.overview)
        videoView.getVideo(model: viewModel.tvVideoModel)
        castView.updateCastView(model: viewModel.tvCastModel)
        
        castView.isHidden = viewModel.tvCastModel.isEmpty
        videoView.isHidden = viewModel.tvVideoModel.isEmpty
        similarView.hiddenIfNoData()
    }
    
    func tvCastSelected(castID: Int) {
        let castDetailVC = CastDetailFactory.makeCastDetailVC(castID: castID)
        navigationController?.pushViewController(castDetailVC, animated: true)
    }
    
    func similarTVShowSelected(tvShowID: Int) {
        let tvShowDetail = TVShowDetailFactory.makeCastDetailVC(tvShowID: tvShowID)
        navigationController?.pushViewController(tvShowDetail, animated: true)
    }
    
    @objc
    func addButtonTapped() {
        WatchListStore.shared.updateMedia(viewModel.model.storeableMedia)
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

