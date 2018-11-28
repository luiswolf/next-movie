//
//  MovieListTableViewController.swift
//  NextMovie
//
//  Created by Luís Wolf on 25/11/2018.
//  Copyright © 2018 Luís Wolf. All rights reserved.
//

import UIKit

class MovieListTableViewController: LWTableViewController {
    
    let viewModel = MovieListViewModel()
    
    var detailViewController: MovieDetailViewController? = nil
    var isFirstLoad: Bool = true
    fileprivate lazy var imageHelper: ImageHelper = {
        let helper = ImageHelper()
        return helper
    }()
    
    fileprivate let goToDetailIdentifier = "showDetail"
    fileprivate let cellIdentifier = "movieCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let info = Bundle.main.infoDictionary, let appName = info["CFBundleDisplayName"] as? String {
            title = appName
        }
        
        if let split = splitViewController {
            split.preferredDisplayMode = .allVisible
            let controllers = split.viewControllers
            detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? MovieDetailViewController
        }
        viewModel.delegate = self
        getData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        navigationController?.setNavigationBarHidden(false, animated: true)
        super.viewWillAppear(animated)
    }
    
    func getData() {
        if isFirstLoad { startLoading() }
        tableView.reloadSections(IndexSet(integer: TableSection.loading.rawValue), with: .none)
        viewModel.getList()
    }
    
    // MARK: - Segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == goToDetailIdentifier {
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            let movie = viewModel.movieList[indexPath.row]
            if let navigationController = segue.destination as? UINavigationController, let vc = navigationController.topViewController as? MovieDetailViewController {
                vc.title = movie.title
                vc.movie = movie
                vc.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                vc.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }
    
    @IBAction func unwindToMovieListViewController(segue : UIStoryboardSegue) {}
}

// - MARK: TableView
extension MovieListTableViewController {
    enum TableSection: Int {
        case movie, loading
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let section = TableSection(rawValue: section) else { return nil }
        if section == .movie { return NSLocalizedString("UPCOMING MOVIES", comment: "Upcoming movies header title") }
        return nil
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard let section = TableSection(rawValue: section) else { return UITableView.automaticDimension }
        if section == .loading { return .leastNonzeroMagnitude }
        return UITableView.automaticDimension
    }
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return .leastNonzeroMagnitude
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = TableSection(rawValue: section) else { return 0 }
        if section == .movie { return viewModel.movieList.count }
        if section == .loading && viewModel.canGetData { return 1 }
        return 0
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = TableSection(rawValue: indexPath.section) else { return UITableViewCell() }
        switch section {
            case .movie:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? MovieTableViewCell else { return UITableViewCell() }
                let movie = viewModel.movieList[indexPath.row]
                if let posterPath = viewModel.posterPath {
                    imageHelper.getImage(withPath: posterPath + movie.posterPath) { (image) in
                        if let image = image {
                            cell.posterImageView.image = image
                        }
                    }
                }
                cell.titleLabel.text = movie.title
                let genreList = Array(movie.genres.map{ $0.name })
                cell.genreLabel.text = genreList.joined(separator: ", ")
                cell.releaseDateLabel.text = DateHelper.sharedInstance.getFormattedDate(from: movie.releaseDate)
                return cell
            case .loading:
                // TODO: loading cell
                return UITableViewCell()
        }
    }
}

// - MARK: ScrollView
extension MovieListTableViewController {
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        if viewModel.canGetData && offsetY > contentHeight - scrollView.frame.height * 4 {
            viewModel.getList(forNextPage: true)
        }
    }
}

// MARK: - IB Actions
extension MovieListTableViewController: ErrorViewDelegate {
    func didPressRetryButton() {
        hideError()
        getData()
    }
}

// MARK: - UI Helper
extension MovieListTableViewController {
    fileprivate func errorAction(isOffline: Bool, message: String? = nil) {
        stopLoading()
        errorView.isOffline = isOffline
        if let message = message {
            errorView.message = message
        }
        errorView.delegate = self
        showError()
    }
    fileprivate func successAction() {
        // TODO: dont reload all tableview everytime
        tableView.reloadData()
        if UIDevice.current.userInterfaceIdiom == .pad, isFirstLoad, let firstIndexPath = tableView.indexPathsForVisibleRows?.first {
            isFirstLoad = false
            tableView.selectRow(at: firstIndexPath, animated: true, scrollPosition: .none)
            self.performSegue(withIdentifier: goToDetailIdentifier, sender: nil)
        }
        stopLoading()
    }
}

// - MARK: CharacterListViewModel Delegate
extension MovieListTableViewController: MovieListViewModelDelegate {
    func didGetData() {
        successAction()
    }
    func didFailWith(errorMessage: String) {
        errorAction(isOffline: false)
    }
    func didFailWithNoConnection() {
        errorAction(isOffline: true)
    }
}
