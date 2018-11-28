//
//  Movie.swift
//  NextMovie
//
//  Created by Luís Wolf on 25/11/2018.
//  Copyright © 2018 Luís Wolf. All rights reserved.
//

import Foundation
import ObjectMapper

struct MovieWrapper: Mappable {
    var movies: [Movie] = [Movie]()
    init?(map: Map) {}
    mutating func mapping(map: Map) {
        movies <- map["results"]
    }
}

struct Movie: Mappable {
    
    var id: Int = -1
    var voteAverage: Double = 0.0
    var title: String = ""
    var originalTitle: String = ""
    var popularity: Double = 0.0
    var voteCount: Int = 0
    var posterPath: String = ""
    var backdropPath: String = ""
    var overview: String = ""
    var releaseDate: Date = Date()
    var genres: [Genre] = [Genre]()
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        voteAverage <- map["vote_average"]
        title <- map["title"]
        originalTitle <- map["original_title"]
        popularity <- map["popularity"]
        voteCount <- map["vote_count"]
        posterPath <- map["poster_path"]
        backdropPath <- map["backdrop_path"]
        overview <- map["overview"]
        releaseDate <- (map["release_date"], DateFormatTransform())
        if let genreIds = map.JSON["genre_ids"] as? [Int], let sharedGenreList = CacheHelper.sharedInstance.genreList {
            var genreList = [Genre]()
            for genreId in genreIds {
                if let genre = sharedGenreList.get(byId: genreId) {
                    genreList.append(genre)
                }
            }
            genres = genreList
        } else {
            genres <- map["genres"]
        }
    }
}
