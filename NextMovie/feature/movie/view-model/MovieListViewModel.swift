//
//  MovieListViewModel.swift
//  NextMovie
//
//  Created by Luís Wolf on 26/11/2018.
//  Copyright © 2018 Luís Wolf. All rights reserved.
//

import Foundation
protocol MovieListViewModelDelegate: ResponseRequestProtocol {
    func didGetData()
}

class MovieListViewModel {
    
    var movieList = [Movie]()
    private var page: Int = 1
    var canGetData: Bool = true
    let posterPath = ApiHelper.getPosterPath()
    
    fileprivate var service: MovieService!
    var delegate: MovieListViewModelDelegate?
    
    init(service: MovieService = MovieService()) {
        self.service = service
    }
    
    func getList(forNextPage nextPage: Bool = false) {
        guard canGetData else { return }
        
//        delegate?.didFailWithNoConnection()
//        return;
        
        if nextPage { page += 1 }
        service.getList(atPage: self.page) { [weak self] response in
            guard let sself = self else { return }
            if response.success, let movieList = response.data?.movies {
                if !movieList.isEmpty {
                    for movie in movieList {
                        sself.movieList.append(movie)
                    }
                    sself.canGetData = true
                } else {
                    sself.canGetData = false
                }
                sself.delegate?.didGetData()
            } else {
                sself.canGetData = true
                if NetworkHelper.sharedInstance.isOnline() {
                    sself.delegate?.didFailWith(errorMessage: response.message)
                } else {
                    sself.delegate?.didFailWithNoConnection()
                }
            }
        }
    }
    
}
