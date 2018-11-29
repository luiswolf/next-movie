//
//  CacheHelper.swift
//  NextMovie
//
//  Created by Luís Wolf on 26/11/2018.
//  Copyright © 2018 Luís Wolf. All rights reserved.
//

import UIKit
import CoreLocation

class CacheHelper {
    var genreList: GenreWrapper?
    private let image = NSCache<NSString, UIImage>()
    
    static let sharedInstance = CacheHelper()
    private init() {}
}

// MARK: - Image
extension CacheHelper {
    func getImage(forKey key: String) -> UIImage? {
        return image.object(forKey: NSString(string: key))
    }
    func storeImage(_ image: UIImage, forKey key: String) {
        guard getImage(forKey: key) == nil else { return }
        self.image.setObject(image, forKey: NSString(string: key))
    }
}
