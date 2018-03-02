//
//  NowPlayingViewController.swift
//  Flix_Assignment1
//
//  Created by Mike Lin on 1/30/18.
//  Copyright © 2018 Mike Lin. All rights reserved.
//

import UIKit
import AlamofireImage


class NowPlayingViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var refreshingIndicator: UIActivityIndicatorView!
    
    var movies: [Movie] = []
    
    var refreshControl: UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        fetchMovies(refreshControl)
    }
    
    @objc func fetchMovies(_ refreshControl: UIRefreshControl) {
        self.refreshingIndicator.startAnimating()
        MovieApiManager().nowPlayingMovies { (movies: [Movie]?, error: Error?) in
            if let movies = movies {
                self.movies = movies
                self.tableView.reloadData()
                self.refreshControl.endRefreshing()
            } else if let error = error {
                self.handleNetworkError()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! UITableViewCell
        if let indexPath = tableView.indexPath(for: cell) {
            let movie = movies[indexPath.row]
            let detailViewController = segue.destination as! DetailViewController
            detailViewController.movie = movie
        }
    }
    
    func handleNetworkError() {
        let alertTitle = "Cannot get movies"
        let alertMessage = "Network connection appears to be down, please try again"
        let alertController = UIAlertController(title: alertTitle,
                                                message: alertMessage, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
            self.fetchMovies(self.refreshControl)
        }
        alertController.addAction(OKAction)
        self.present(alertController, animated: true) {}
    }
}

extension NowPlayingViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        cell.movie = movies[indexPath.row]
        return cell
    }
}

extension NowPlayingViewController: UITableViewDataSource {
    func setUpViews() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self,
                                 action: #selector(NowPlayingViewController.fetchMovies(_:)),
                                 for: .valueChanged)
        tableView.insertSubview(refreshControl, at: 0)
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 50
    }
}


