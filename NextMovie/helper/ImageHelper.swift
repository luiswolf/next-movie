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
    let imageTypes = ["image/png", "image/jpeg"]
    
    var delegate: ImageHelperDelegate!
    
    func getImage(withPath path: String) {
        if let image = CacheHelper.sharedInstance.getImage(forKey: path) {
            delegate.didGetImage(image: image, forPath: path)
        } else {
            // TODO: COLOCAR EM CAMADA DE SERVICO
            Alamofire.request(path)
                .validate(contentType: self.imageTypes)
                .responseData { response in
                    switch response.result {
                    case .success:
                        if let data = response.data, let image = UIImage(data: data) {
                            CacheHelper.sharedInstance.storeImage(image, forKey: path)
                            self.delegate.didGetImage(image: image, forPath: path)
                        } else {
                            self.delegate.didFailToGetImage(forPath: path)
                        }
                    case .failure:
                        self.delegate.didFailToGetImage(forPath: path)
                    }
            }
        }
    }
}
