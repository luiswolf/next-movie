//
//  MovieListTableViewController.swift
//  NextMovie
//
//  Created by Luís Wolf on 25/11/2018.
//  Copyright © 2018 Luís Wolf. All rights reserved.
//

import UIKit

class MovieListTableViewController: UITableViewController {

    var detailViewController: MovieDetailViewController? = nil
    
    fileprivate let goToDetailIdentifier = "goToDetail"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let split = splitViewController {
            split.preferredDisplayMode = .allVisible
            let controllers = split.viewControllers
            detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? MovieDetailViewController
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

    // MARK: - Segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == goToDetailIdentifier, let nc = segue.destination as? UINavigationController, let vc = nc.topViewController as? MovieDetailViewController, let indexPath =
            tableView.indexPathForSelectedRow  {
            vc.detailItem = "Temp #\(indexPath.row + 1)"
            vc.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
            vc.navigationItem.leftItemsSupplementBackButton = true
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: goToDetailIdentifier, sender: nil)
    }
}
