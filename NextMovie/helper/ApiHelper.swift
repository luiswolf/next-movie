//
//  ApiHelper.swift
//  NextMovie
//
//  Created by Luís Wolf on 25/11/2018.
//  Copyright © 2018 Luís Wolf. All rights reserved.
//

import Foundation

enum ApiEndpoint: String {
    case movieList = "MOVIE_UPCOMING_LIST"
    case movieDetail = "MOVIE_DETAIL"
    case movieGenreList = "MOVIE_GENRE_LIST"
    case movieSearch = "MOVIE_SEARCH"
}

class ApiHelper {
    fileprivate static let configurationFile = "ApiConstant"
    fileprivate static let endpoints = "API_ENDPOINTS"
    fileprivate static let url = "API_URL"
    fileprivate static let apiKey = "API_KEY"
    fileprivate static let posterPath = "POSTER_PATH"
    fileprivate static let backdropPath = "BACKDROP_PATH"
    
    static func get(endpoint: ApiEndpoint, withPage page: Int? = nil) -> String? {
        guard let mainDict = self.get(dictForConfigurationFile: self.configurationFile) else { return nil }
        guard var url = mainDict[self.url] as? String else { return nil }
        guard let apiKey = mainDict[self.apiKey] as? String else { return nil }
        guard let endpointDict = self.getEndpointDict() else { return nil }
        guard let endpoint = endpointDict[endpoint.rawValue] as? String else { return nil }
        
        url.append(endpoint)
        
        if var urlComps = URLComponents(string: url) {
            var locale = Locale.current.languageCode ?? "en-US"
            if let l = Locale.preferredLanguages.first {
                locale = l
            }
            
            if urlComps.queryItems == nil {
                urlComps.queryItems = [URLQueryItem]()
            }
            urlComps.queryItems?.append(URLQueryItem(name: "api_key", value: apiKey))
            urlComps.queryItems?.append(URLQueryItem(name: "language", value: locale))
            if let page = page {
                urlComps.queryItems?.append(URLQueryItem(name: "page", value: String(page)))
            }
            return urlComps.url?.absoluteString
        }
        
        return nil
    }
    
    private static func get(dictForConfigurationFile configurationFile: String) -> NSDictionary? {
        guard
            let path = Bundle.main.path(forResource: configurationFile, ofType: "plist"),
            let dict = NSDictionary(contentsOfFile: path)
            else {
                return nil
        }
        return dict
    }
    private static func getEndpointDict() -> NSDictionary? {
        guard let mainDict = get(dictForConfigurationFile: self.configurationFile) else { return nil }
        return mainDict[self.endpoints] as? NSDictionary
    }
    
    static func getPosterPath() -> String? {
        guard let mainDict = get(dictForConfigurationFile: self.configurationFile) else { return nil }
        return mainDict[self.posterPath] as? String
    }
    static func getBackdropPath() -> String? {
        guard let mainDict = get(dictForConfigurationFile: self.configurationFile) else { return nil }
        return mainDict[self.backdropPath] as? String
    }
}
