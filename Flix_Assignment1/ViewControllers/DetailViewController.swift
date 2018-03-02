//
//  DetailViewController.swift
//  Flix_Assignment1
//
//  Created by Mike Lin on 2/6/18.
//  Copyright © 2018 Mike Lin. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var backDropImageView: UIImageView!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    
    var movie: Movie?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let movie = movie {
            self.view.backgroundColor = UIColor.black
            navigationItem.title = movie.title
            titleLabel.text = movie.title
            releaseDateLabel.text = movie.releaseDate
            overviewLabel.text = movie.overview
            if movie.posterURL != nil {
                posterImageView.af_setImage(withURL: movie.posterURL!)
            }
            if movie.backdropURL != nil {
                backDropImageView.af_setImage(withURL: movie.backdropURL!)
            }
        }

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
