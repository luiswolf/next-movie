//
//  MovieDetailTableViewController.swift
//  NextMovie
//
//  Created by Luís Wolf on 27/11/2018.
//  Copyright © 2018 Luís Wolf. All rights reserved.
//

import UIKit

class MovieDetailTableViewController: UITableViewController {
    
    var colors: UIImageColors!
    var movie: Movie!
    var delegate: LWContainerViewHeightDelegate?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var originalTitleLabel: UILabel!
    @IBOutlet weak var genresLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    
    let formatter = DateFormatter()
    
    static let storyboardName: String = "Movie"
    static func prepareViewController() -> MovieDetailTableViewController {
        let storyboard = UIStoryboard(name: self.storyboardName, bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "MovieDetailTableViewController") as! MovieDetailTableViewController
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = 100.0
        tableView.rowHeight = UITableView.automaticDimension
        tableView.backgroundColor = .clear
        tableView.separatorColor = colors.background.lighter() == .white ? colors.primary.withAlphaComponent(0.2) : colors.background
        tableView.cellLayoutMarginsFollowReadableWidth = false
        configure()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        delegate?.didChange(height: tableView.contentSize.height)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        delegate?.didChange(height: tableView.contentSize.height)
    }
}

// - MARK: UI Helper
extension MovieDetailTableViewController {
    func configure() {
        // MARK: TITLE
        titleLabel.text = movie.title
        originalTitleLabel.text = movie.originalTitle
        
        // MARK: GENRE
        let genre = NSMutableAttributedString(
            string: NSLocalizedString("Genre: ", comment: "Movie gender"),
            attributes: [.font : UIFont.textSemibold]
        )
        let genreList = Array(movie.genres.map{ $0.name })
        genre.append(
            NSAttributedString(
                string: genreList.joined(separator: ", "),
                attributes: [.font : UIFont.text]
            )
        )
        genresLabel.attributedText = genre
        
        // MARK: RELEASE DATE
        let releaseDate = NSMutableAttributedString(
            string: NSLocalizedString("Release date: ", comment: "Movie's release date"),
            attributes: [.font : UIFont.textSemibold]
        )
        releaseDate.append(
            NSAttributedString(
                string: DateHelper.sharedInstance.getFormattedDate(from: movie.releaseDate),
                attributes: [.font : UIFont.text]
            )
        )
        releaseDateLabel.attributedText = releaseDate
        
        // MARK: RATING
        
        let rate = NSMutableAttributedString(
            string: NSLocalizedString("Rating: ", comment: "Movie's rating"),
            attributes: [.font : UIFont.textSemibold]
        )
        let formatString = NSLocalizedString("%.1f (%d votes)",
                                             comment: "Movie's vote number and avarage")
        
        rate.append(
            NSAttributedString(
                string: String.localizedStringWithFormat(formatString, movie.voteAverage, movie.voteCount),
                attributes: [.font : UIFont.text]
            )
        )
        rateLabel.attributedText = rate
        
        // MARK: OVERVIEW
        overviewLabel.text = movie.overview
    }
}

// - MARK: TableView
extension MovieDetailTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        if movie.overview.isEmpty { return 1 }
        return super.numberOfSections(in: tableView)
    }
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.textColor = colors.primary
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        cell.contentView.backgroundColor = colors.background.lighter(by: 80.0).withAlphaComponent(0.3)
        if cell.responds(to: #selector(setter: UITableViewCell.separatorInset)) {
            cell.separatorInset = UIEdgeInsets.zero
        }
        if cell.responds(to: #selector(setter: UIView.preservesSuperviewLayoutMargins)) {
            cell.preservesSuperviewLayoutMargins = false
        }
        if cell.responds(to: #selector(setter: UIView.layoutMargins)) {
            cell.layoutMargins = UIEdgeInsets.zero
        }
        cell.backgroundColor = UIColor.white
        cell.textLabel?.backgroundColor = .clear
        cell.detailTextLabel?.backgroundColor = .clear
        return cell
    }
}
