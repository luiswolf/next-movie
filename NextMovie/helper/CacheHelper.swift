//
//  CacheHelper.swift
//  NextMovie
//
//  Created by Luís Wolf on 26/11/2018.
//  Copyright © 2018 Luís Wolf. All rights reserved.
//

import Foundation
import CoreLocation

class CacheHelper {
    var genreList: GenreWrapper?
//    private let image = NSCache<NSString, UIImage>()
    
    static let sharedInstance = CacheHelper()
    private init() {}
}
