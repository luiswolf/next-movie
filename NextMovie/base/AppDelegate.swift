//
//  AppDelegate.swift
//  NextMovie
//
//  Created by Luís Wolf on 24/11/2018.
//  Copyright © 2018 Luís Wolf. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = RootViewController()
        window?.makeKeyAndVisible()
        AppDelegate.configureMainAppearance()
        return true
    }
}

extension AppDelegate {
    static var shared: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    var rootViewController: RootViewController {
        return window!.rootViewController as! RootViewController
    }
}

extension AppDelegate {
    fileprivate static func configureMainAppearance() {
        UINavigationBar.appearance().barTintColor = UIColor.white.withAlphaComponent(0.5)
        UINavigationBar.appearance().tintColor = UIColor.black.withAlphaComponent(0.8)
        UINavigationBar.appearance().titleTextAttributes = [
            .foregroundColor : UIColor.black.withAlphaComponent(0.8)
        ]
    }
}
