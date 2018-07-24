//
//  NowPlayingViewController.swift
//  Flix_Assignment1
//
//  Created by Mike Lin on 1/30/18.
//  Copyright © 2018 Mike Lin. All rights reserved.
//

import UIKit
import AlamofireImage


class NowPlayingViewController: UITableViewController {
    
    let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        return indicator
    }()
    
    var movies: [Movie] = []
    var filteredMovies: [Movie] = []
    let searchController = UISearchController(searchResultsController: nil)

//    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        let offsetY = scrollView.contentOffset.y
//        let contentHeight = scrollView.contentSize.height
//
//        if offsetY > contentHeight - scrollView.frame.size.height {
//            fetchMovies()
//            self.tableView.reloadData()
//        }
//    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "Flix"
        tableView.register(MovieCell.self, forCellReuseIdentifier: "MovieCell")
        setupSearchController()
        setupRefreshControl()
        fetchMovies()
    }
    
    func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = false
        tableView.tableHeaderView = searchController.searchBar
    }
    
    func setupRefreshControl() {
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(fetchMovies), for: .valueChanged)
    }

    @objc func fetchMovies() {
        guard let refreshControl = refreshControl else { return }
        refreshControl.beginRefreshing()
        MovieApiManager().nowPlayingMovies { (movies: [Movie]?, error: Error?) in
            if let movies = movies {
                self.movies = movies
                self.filteredMovies = movies
                self.tableView.reloadData()
                refreshControl.endRefreshing()
            } else if let error = error {
                self.handleNetworkError()
                print(error)
            }
        }
    }
    
    func handleNetworkError() {
        let alertTitle = "Cannot get movies"
        let alertMessage = "Network connection appears to be down, please try again"
        let alertController = UIAlertController(title: alertTitle,
                                                message: alertMessage, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
            self.fetchMovies()
        }
        alertController.addAction(OKAction)
        self.present(alertController, animated: true) {}
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = filteredMovies[indexPath.row]
        let detailVC = DetailViewController()
        detailVC.movie = movie
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        cell.movie = filteredMovies[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredMovies.count
    }
}

extension NowPlayingViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text, !searchText.isEmpty {
            filteredMovies = movies.filter({ (movie) -> Bool in
                return movie.title.lowercased().contains(searchText.lowercased())
            })
        } else {
            filteredMovies = movies
        }
        tableView.reloadData()
    }
}


