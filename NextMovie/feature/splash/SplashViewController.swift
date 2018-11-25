//
//  SplashViewController.swift
//  NextMovie
//
//  Created by Luís Wolf on 24/11/2018.
//  Copyright © 2018 Luís Wolf. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(ApiHelper.get(endpoint: .movieList, withPage: 1))
        print(ApiHelper.get(endpoint: .movieDetail))
        print(ApiHelper.get(endpoint: .movieGenreList))
        print(ApiHelper.get(endpoint: .movieSearch, withPage: 1))
        print(ApiHelper.getPosterPath())
        print(ApiHelper.getBackdropPath())
//        print("LOADING CONTENT")
//        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
//            print("REDIRECTING")
//            AppDelegate.shared.rootViewController.switchToMovie()
//        }
        
    }


}

