//
//  SplashViewModel.swift
//  NextMovie
//
//  Created by Luís Wolf on 26/11/2018.
//  Copyright © 2018 Luís Wolf. All rights reserved.
//

import Foundation

protocol SplashViewModelDelegate: ResponseRequestProtocol {
    func didGetGenreList()
}

class SplashViewModel: NSObject {
    
    fileprivate var movieService: MovieService!
    
    var delegate: SplashViewModelDelegate?
    var genreList: [Genre]?
    
    init(movieService: MovieService = MovieService()) {
        self.movieService = movieService
        super.init()
    }
    
    func getGenreList() {
//        delegate?.didFailWith(errorMessage: "Test")
//        delegate?.didFailWithNoConnection()
//        return;
        movieService.getGenres { [weak self] response in
            guard let sself = self else { return }
            if response.success, let genreList = response.data?.genres {
                sself.genreList = genreList.sorted(by: { (g0, g1) -> Bool in
                    return g0.name < g1.name
                })
                CacheHelper.sharedInstance.genreList = GenreWrapper(genres: sself.genreList ?? [Genre]())
                sself.delegate?.didGetGenreList()
            } else {
                if NetworkHelper.sharedInstance.isOnline() {
                    sself.delegate?.didFailWith(errorMessage: response.message)
                } else {
                    sself.delegate?.didFailWithNoConnection()
                }
            }
        }
    }
    
//    func getSectionTitle(forSortingOption sortingOption: EventService.EventListSortType) -> String {
//        switch sortingOption {
//        case let .date(order):
//            return "ordenados por data (\(order == .asc ? "a - z" : "z - a"))"
//        case let .title(order):
//            return "ordenados por título (\(order == .asc ? "a - z" : "z - a"))"
//        }
//    }
}
