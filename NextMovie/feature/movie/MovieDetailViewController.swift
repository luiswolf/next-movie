//
//  MovieDetailViewController.swift
//  NextMovie
//
//  Created by Luís Wolf on 25/11/2018.
//  Copyright © 2018 Luís Wolf. All rights reserved.
//

import UIKit

class MovieDetailViewController: LWViewController {
    
    var movie: Movie!
    fileprivate var colors: UIImageColors?
    let viewModel = MovieDetailViewModel()
    fileprivate let isIpad = UIDevice.current.userInterfaceIdiom == .pad
    
    @IBOutlet weak var customBackButton: UIButton!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var containerViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var imageAreaView: UIView!
    
    fileprivate lazy var imageHelper: ImageHelper = {
        let helper = ImageHelper()
        helper.delegate = self
        return helper
    }()
    private lazy var detailViewController: MovieDetailTableViewController = {
        let viewController = MovieDetailTableViewController.prepareViewController()
        viewController.delegate = self
        if let movie = viewModel.movie, let colors = colors {
            viewController.colors = colors
            viewController.movie = movie
        }
        return viewController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        getData()
        UINavigationController.attemptRotationToDeviceOrientation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        customBackButton.isHidden = isIpad
        navigationController?.setNavigationBarHidden(!isIpad, animated: true)
    }
    
    func getData() {
        startLoading()
        if let movie = movie {
            viewModel.getDetail(withId: movie.id)
        }
    }
}

// - MARK: TableViewHeight Delegate
extension MovieDetailViewController: LWContainerViewHeightDelegate {
    func didChange(height: CGFloat) {
        containerViewHeightConstraint.constant = height
    }
}

// - MARL: UI Helper
extension MovieDetailViewController {
    func configureView() {
        imageAreaView.clipsToBounds = false
        imageAreaView.layer.shadowColor = UIColor.black.cgColor
        imageAreaView.layer.shadowOpacity = 1
        imageAreaView.layer.shadowOffset = CGSize.zero
        imageAreaView.layer.shadowRadius = 5
        imageAreaView.backgroundColor = .clear
        imageAreaView.layer.shadowPath = UIBezierPath(roundedRect: imageAreaView.bounds, cornerRadius: 5).cgPath
        updateImages()
    }
    func configureDetail() {
        add(child: detailViewController, toContainer: containerView)
    }
    func updateImages() {
        guard let movie = viewModel.movie else { return }
        if let backdropPath = viewModel.backdropPath {
            imageHelper.getImage(withPath: backdropPath + movie.backdropPath)
        }
        if let posterPath = viewModel.posterPath {
            imageHelper.getImage(withPath: posterPath + movie.posterPath)
        }
    }
}

// MARK: - UI Helper
extension MovieDetailViewController {
    fileprivate func errorAction(isOffline: Bool, message: String? = nil) {
        stopLoading()
        errorView.isOffline = isOffline
        if let message = message {
            errorView.message = message
        }
        errorView.delegate = self
        showError()
    }
    fileprivate func successAction() {
        configureView()
    }
}

// - MARK: MovieDetailViewModel Delegate
extension MovieDetailViewController : MovieDetailViewModelDelegate {
    func didGetData() {
        successAction()
    }
    func didFailWith(errorMessage: String) {
        errorAction(isOffline: false)
    }
    func didFailWithNoConnection() {
        errorAction(isOffline: true)
    }
}

// MARK: - IB Actions
extension MovieDetailViewController: ErrorViewDelegate {
    func didPressRetryButton() {
        hideError()
        getData()
    }
}

// MARK: - ImageHelper Delegate
extension MovieDetailViewController: ImageHelperDelegate {
    func didGetImage(image: UIImage, forPath path: String) {
        guard let movie = viewModel.movie else { return }
        if let posterPath = viewModel.posterPath, path == (posterPath + movie.posterPath) {
            let myImage = UIImageView(frame: imageAreaView.bounds)
            myImage.clipsToBounds = true
            myImage.layer.cornerRadius = 5
            myImage.layer.masksToBounds = true
            myImage.image = image
            myImage.contentMode = .scaleAspectFill
            imageAreaView.addSubview(myImage)
            imageAreaView.sendSubviewToBack(backgroundImageView)
            let colors = image.getColors()
            self.colors = colors
            configureDetail()
            stopLoading()
            customBackButton.tintColor = colors.primary
            UIView.animate(withDuration: 0.3, animations: {
                self.view.backgroundColor = colors.background
                self.imageAreaView.isHidden = false
            })
        }
        if let backdropPath = viewModel.backdropPath, path == (backdropPath + movie.backdropPath) {
            backgroundImageView.image = image
        }
    }
    func didFailToGetImage(forPath path: String) {
        guard let movie = viewModel.movie else { return }
        if let posterPath = viewModel.posterPath, path == (posterPath + movie.posterPath) {
            stopLoading()
        }
    }
}
