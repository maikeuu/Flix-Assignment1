//
//  SuperHeroViewController.swift
//  Flix_Assignment1
//
//  Created by Mike Lin on 2/6/18.
//  Copyright © 2018 Mike Lin. All rights reserved.
//

import UIKit

class GalleryViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    
    var movies: [Movie] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchMovies()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "Now Playing"
        collectionView?.register(PosterCell.self, forCellWithReuseIdentifier: "PosterCell")
    }
    
    func fetchMovies() {
        MovieApiManager().nowPlayingMovies { (movies: [Movie]?, error: Error?) in
            if let movies = movies {
                self.movies = movies
                self.collectionView!.reloadData()
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
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = movies[indexPath.row]
        let detailVC = DetailViewController()
        detailVC.movie = movie
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PosterCell", for: indexPath) as! PosterCell
        let movie = movies[indexPath.row]
        if let posterURL = movie.posterURL {
            cell.posterImageView.af_setImage(withURL: posterURL)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.width - 1)/2, height: 300)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
}

