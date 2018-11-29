//
//  ImageHelper.swift
//  NextMovie
//
//  Created by Luís Wolf on 27/11/2018.
//  Copyright © 2018 Luís Wolf. All rights reserved.
//

import UIKit
import Alamofire

protocol ImageHelperDelegate {
    func didGetImage(image: UIImage, forPath path: String)
    func didFailToGetImage(forPath path: String)
}

class ImageHelper {
    var delegate: ImageHelperDelegate?
    var requestHelper = RequestHelper()
    
    func getImage(withPath path: String) {
        if let image = CacheHelper.sharedInstance.getImage(forKey: path) {
            delegate?.didGetImage(image: image, forPath: path)
        } else {
            requestHelper.download(fromUrl: path) { (data) in
                if let data = data, let image = UIImage(data: data) {
                    CacheHelper.sharedInstance.storeImage(image, forKey: path)
                    self.delegate?.didGetImage(image: image, forPath: path)
                } else {
                    self.delegate?.didFailToGetImage(forPath: path)
                }
            }
        }
    }
    
    func getImage(withPath path: String, withCompletion completion: @escaping (UIImage?)->Void) {
        if let image = CacheHelper.sharedInstance.getImage(forKey: path) {
            completion(image)
        } else {
            requestHelper.download(fromUrl: path) { (data) in
                if let data = data, let image = UIImage(data: data) {
                    CacheHelper.sharedInstance.storeImage(image, forKey: path)
                    completion(image)
                } else {
                    completion(nil)
                }
            }
        }
    }
}
