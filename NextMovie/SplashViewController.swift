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
        
        print("LOADING CONTENT")
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            print("REDIRECTING")
            AppDelegate.shared.rootViewController.switchToMovie()
        }
        
    }


}

