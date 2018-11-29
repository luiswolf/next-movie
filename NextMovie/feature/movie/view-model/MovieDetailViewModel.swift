//
//  MovieDetailViewModel.swift
//  NextMovie
//
//  Created by Luís Wolf on 27/11/2018.
//  Copyright © 2018 Luís Wolf. All rights reserved.
//

import Foundation
import Alamofire

protocol MovieDetailViewModelDelegate: ResponseRequestProtocol {
    func didGetData()
}

class MovieDetailViewModel {

    var movie: Movie?
    let backdropPath = ApiHelper.getBackdropPath()
    let posterPath = ApiHelper.getPosterPath()
    
    fileprivate var movieService: MovieService!
    var delegate: MovieDetailViewModelDelegate?
    
    init(movieService: MovieService = MovieService()) {
        self.movieService = movieService
    }
    
    func getDetail(withId id: Int) {
//        delegate?.didFailWith(errorMessage: "Test")
//        delegate?.didFailWithNoConnection()
//        return;
        
        movieService.getDetail(withId: id) { [weak self] response in
            guard let sself = self else { return }
            if response.success, let movie = response.data {
                sself.movie = movie
                sself.delegate?.didGetData()
            } else {
                if NetworkHelper.sharedInstance.isOnline() {
                    sself.delegate?.didFailWith(errorMessage: response.message)
                } else {
                    sself.delegate?.didFailWithNoConnection()
                }
            }
        }
    }
}
