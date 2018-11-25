//
//  Genre.swift
//  NextMovie
//
//  Created by Luís Wolf on 25/11/2018.
//  Copyright © 2018 Luís Wolf. All rights reserved.
//

import Foundation
import ObjectMapper

struct GenreWrapper: Mappable {
    var genres: [Genre] = [Genre]()
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        genres <- map["genres"]
    }
}

struct Genre: Mappable {
    var id: Int = -1
    var name: String = ""
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
    }
}
