//
//  SplashViewController.swift
//  NextMovie
//
//  Created by Luís Wolf on 24/11/2018.
//  Copyright © 2018 Luís Wolf. All rights reserved.
//

import UIKit

class SplashViewController: LWViewController {

    var viewModel = SplashViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.delegate = self
        getData()
        
        /*
        let service = MovieService()
        service.getList(atPage: 1) { response in
            if response.success, let movieList = response.data?.movies {
                for movie in movieList {
                    print(movie.title)
                }
            }
        }
        service.getDetail(withId: 360920) { response in
            if response.success, let movie = response.data {
                print(movie.title)
            }
        }
        service.getGenres { response in
            if response.success, let genreList = response.data?.genres {
                for genre in genreList {
                    print(genre.name)
                }
            }
        }
        service.search(for: "Reprisa", withPage: 1) { response in
            if response.success, let movieList = response.data?.movies {
                for movie in movieList {
                    print(movie.title)
                    print(movie.overview)
                }
            }
        }
 */
        
    }
}

// MARK: - UI Helper
extension SplashViewController {
    fileprivate func getData() {
        viewModel.getGenreList()
    }
    fileprivate func errorAction(isOffline: Bool, message: String? = nil) {
        errorView.isOffline = isOffline
        if let message = message {
            errorView.message = message
        }
        errorView.delegate = self
        showError()
    }
    func successAction() {
        guard viewModel.genreList != nil else {
            errorAction(isOffline: false)
            return
        }
        AppDelegate.shared.rootViewController.switchToMovie()
    }
}

// MARK: - IB Actions
extension SplashViewController: ErrorViewDelegate {
    func didPressRetryButton() {
        hideError()
        getData()
    }
}

// MARK: - SplashViewModel Delegate
extension SplashViewController: SplashViewModelDelegate {
    func didGetGenreList() {
        successAction()
    }
    func didFailWith(errorMessage: String) {
        errorAction(isOffline: false)
    }
    func didFailWithNoConnection() {
        errorAction(isOffline: true)
    }
}
