//
//  LWViewControllerProtocol.swift
//  EventGuideApp
//
//  Created by Luís Wolf on 15/11/2018.
//  Copyright © 2018 Luís Wolf. All rights reserved.
//

import UIKit

protocol LWViewControllerProtocol  {
    func startLoading()
    func stopLoading()
}

extension LWViewControllerProtocol where Self: LWViewController {
    func add(child viewController: UIViewController, toContainer container: UIView) {
        addChild(viewController)
        container.addSubview(viewController.view)
        viewController.view.frame = container.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        viewController.didMove(toParent: self)
    }
    func remove(child viewController: UIViewController) {
        viewController.willMove(toParent: nil)
        viewController.view.removeFromSuperview()
        viewController.removeFromParent()
    }
    func startLoading() {
        view.addSubview(loaderView)
        setConstraints(forView: loaderView)
    }
    func stopLoading() {
        loaderView.removeFromSuperview()
    }
    func showError() {
        errorView.alpha = 0.0
        view.addSubview(errorView)
        setConstraints(forView: errorView)
        errorView.alpha = 1.0
    }
    func hideError() {
        errorView.alpha = 0.0
        errorView.removeFromSuperview()
    }
    private func setConstraints(forView v: UIView) {
        if #available(iOS 11.0, *) {
            v.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0.0).isActive = true
            v.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 0.0).isActive = true
            v.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: 0).isActive = true
            v.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
        } else {
            v.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 0.0).isActive = true
            v.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0.0).isActive = true
            v.widthAnchor.constraint(equalTo: view.widthAnchor, constant: 0.0).isActive = true
            v.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: 0).isActive = true
        }
    }
}

extension LWViewControllerProtocol where Self: LWTableViewController {
    func startLoading() {
        tableView.setContentOffset(.zero, animated: false)
        tableView.isScrollEnabled = false
        isLoaderVisible = true
        if backgroundColor != nil {
            view.backgroundColor = .white
        }
        view.addSubview(loaderView)
        setConstraints(forView: loaderView)
    }
    func stopLoading() {
        if backgroundColor != nil {
            view.backgroundColor = backgroundColor
        }
        tableView.isScrollEnabled = true
        isLoaderVisible = false
        loaderView.removeFromSuperview()
    }
    func showError(animated: Bool = false) {
        tableView.setContentOffset(.zero, animated: false)
        tableView.isScrollEnabled = false
        if backgroundColor != nil {
            view.backgroundColor = .white
        }
        isErrorVisible = true
        view.addSubview(errorView)
        setConstraints(forView: errorView)
        self.errorView.alpha = 1.0
    }
    func hideError(animated: Bool = false) {
        if !isLoaderVisible {
            if backgroundColor != nil {
                view.backgroundColor = backgroundColor
            }
            tableView.isScrollEnabled = true
        }
        errorView.alpha = 0.0
        isErrorVisible = false
        errorView.removeFromSuperview()
    }
    private func setConstraints(forView v: UIView) {
        if #available(iOS 11.0, *) {
            v.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0.0).isActive = true
            v.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 0.0).isActive = true
            v.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: 0).isActive = true
            v.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
        } else {
            v.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 0.0).isActive = true
            v.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0.0).isActive = true
            v.widthAnchor.constraint(equalTo: view.widthAnchor, constant: 0.0).isActive = true
            v.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: 0).isActive = true
        }
    }
}
