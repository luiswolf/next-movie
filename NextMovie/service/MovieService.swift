//
//  MovieService.swift
//  NextMovie
//
//  Created by Luís Wolf on 25/11/2018.
//  Copyright © 2018 Luís Wolf. All rights reserved.
//

import Foundation

class MovieService: NSObject {
    
    let requestHelper: RequestHelperProtocol!
    
    init(requestHelper: RequestHelperProtocol = RequestHelper()) {
        self.requestHelper = requestHelper
    }
    
    func getList(atPage page: Int, andReturnTo callback: @escaping ((ResponseDTO<MovieWrapper>) -> Void)) {
        guard let url = ApiHelper.get(endpoint: .movieList, withPage: page) else { return }
        self.requestHelper.get(type: MovieWrapper.self, fromUrl: url, andReturnTo: callback)
    }
    
    func getDetail(withId id: Int, andReturnTo callback: @escaping ((ResponseDTO<Movie>) -> Void)) {
        guard var url = ApiHelper.get(endpoint: .movieDetail) else { return }
        url = url.replacingOccurrences(of: ":id", with: String(id))
        print(url)
        self.requestHelper.get(type: Movie.self, fromUrl: url, andReturnTo: callback)
    }
    
    func getGenres(andReturnTo callback: @escaping ((ResponseDTO<GenreWrapper>) -> Void)) {
        guard let url = ApiHelper.get(endpoint: .movieGenreList) else { return }
        self.requestHelper.get(type: GenreWrapper.self, fromUrl: url, andReturnTo: callback)
    }
    
    func search(for query: String, withPage page: Int, andReturnTo callback: @escaping ((ResponseDTO<MovieWrapper>) -> Void)) {
        guard var url = ApiHelper.get(endpoint: .movieSearch, withPage: page) else { return }
        url = url.replacingOccurrences(of: ":query", with: query)
        print(url)
        self.requestHelper.get(type: MovieWrapper.self, fromUrl: url, andReturnTo: callback)
    }
}
