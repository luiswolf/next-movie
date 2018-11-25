//
//  LWViewController.swift
//  EventGuideApp
//
//  Created by Luís Wolf on 15/11/2018.
//  Copyright © 2018 Luís Wolf. All rights reserved.
//

import UIKit

class LWViewController: UIViewController, LWViewControllerProtocol {

    lazy var activityIndicator = UIActivityIndicatorView()
    
    lazy var loaderView: UIView = {
        let loader = UIView()
        loader.layer.zPosition = 998
        loader.frame = view.bounds
        loader.translatesAutoresizingMaskIntoConstraints = false
        loader.backgroundColor = .white
        activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        activityIndicator.style = .whiteLarge
        activityIndicator.color = .red
        activityIndicator.hidesWhenStopped = true
        activityIndicator.center = loader.center
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        loader.addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: loader.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: loader.centerYAnchor).isActive = true
        activityIndicator.startAnimating()
        return loader
    }()
    
    lazy var errorView: ErrorView = {
        let errorView = ErrorView()
        errorView.frame = view.bounds
        errorView.layer.zPosition = 999
        errorView.alpha = 0.0
        errorView.translatesAutoresizingMaskIntoConstraints = false
        return errorView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
        }
        navigationController?.navigationBar.isTranslucent = true
        automaticallyAdjustsScrollViewInsets = false
    }
}
