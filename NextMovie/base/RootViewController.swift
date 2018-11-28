//
//  RootViewController.swift
//  NextMovie
//
//  Created by Luís Wolf on 25/11/2018.
//  Copyright © 2018 Luís Wolf. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {

    private var current: UIViewController
    
    init() {
        let storyboard = UIStoryboard(name: "Splash", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SplashViewController") as! SplashViewController
        
        self.current = vc
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addChild(current)
        current.view.frame = view.bounds
        view.addSubview(current.view)
        current.didMove(toParent: self)
    }
    
    func switchToMovie() {
        let storyboard = UIStoryboard(name: "Movie", bundle: nil)
        let splitViewController = storyboard.instantiateViewController(withIdentifier: "MovieSplitViewController") as! UISplitViewController
        
        let navigationController = splitViewController.viewControllers[splitViewController.viewControllers.count-1] as! UINavigationController
        navigationController.topViewController!.navigationItem.leftBarButtonItem = splitViewController.displayModeButtonItem
        splitViewController.delegate = self
        
        addChild(splitViewController)
        
        // overriding trait for iphone 8+, XR, XR Max
        var trait : UITraitCollection?
        if UIDevice.current.userInterfaceIdiom == .pad {
            trait = super.traitCollection
        } else {
            let horizontal = UITraitCollection(horizontalSizeClass: .compact)
            trait = UITraitCollection.init(traitsFrom: [horizontal])
        }
        
        splitViewController.view.frame = view.bounds
        view.addSubview(splitViewController.view)
        splitViewController.didMove(toParent: self)
        setOverrideTraitCollection(trait, forChild: splitViewController)
        current.willMove(toParent: nil)
        current.view.removeFromSuperview()
        current.removeFromParent()
        current = splitViewController
    }

}

extension RootViewController: UISplitViewControllerDelegate {
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController:UIViewController, onto primaryViewController:UIViewController) -> Bool {
        guard let secondaryAsNavController = secondaryViewController as? UINavigationController else { return false }
        guard let topAsDetailController = secondaryAsNavController.topViewController as? MovieDetailViewController else { return false }
        if topAsDetailController.movie == nil {
            return true
        }
        return false
    }
    
    func splitViewController(_ splitViewController: UISplitViewController, showDetail vc: UIViewController, sender: Any?) -> Bool {
        if splitViewController.isCollapsed, let navController = vc as? UINavigationController {
            if let detailVC = navController.topViewController {
                splitViewController.showDetailViewController(detailVC, sender: sender)
                return true
            }
        }
        return false
    }
    
    func splitViewController(_ splitViewController: UISplitViewController, separateSecondaryFrom primaryViewController: UIViewController) -> UIViewController? {
        let controllers = splitViewController.viewControllers
        
        if let navController = controllers[controllers.count - 1] as? UINavigationController {
            if let detailViewController = navController.topViewController as? MovieDetailViewController {
                navController.popViewController(animated: false)
                let detailNavController = UINavigationController(rootViewController: detailViewController)
                return detailNavController
            }
            else if let _ = navController.topViewController as? MovieListTableViewController {
                let storyboard = UIStoryboard(name: "Movie", bundle: nil)
                if let detailNavController = storyboard.instantiateViewController(withIdentifier: "MovieListNavigationController") as? LWNavigationController {
                    if let detailViewController = detailNavController.topViewController as? MovieDetailViewController {
                        detailViewController.navigationItem.leftBarButtonItem = splitViewController.displayModeButtonItem
                        detailViewController.navigationItem.leftItemsSupplementBackButton = true
                    }
                    return detailNavController
                }
            }
        }
        return nil
    }
}
