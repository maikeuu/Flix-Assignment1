//
//  DetailViewController.swift
//  Flix_Assignment1
//
//  Created by Mike Lin on 2/6/18.
//  Copyright © 2018 Mike Lin. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    let backdropImageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .red
        iv.contentMode = .scaleAspectFill
        iv.alpha = 0.75
        return iv
    }()
    
    let posterImageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .blue
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 10
        iv.layer.masksToBounds = true
        return iv
    }()
    
    let titleLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Title Here"
        lb.font = UIFont.boldSystemFont(ofSize: 18)
        lb.numberOfLines = 0
        return lb
    }()
    
    let overviewLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Overview Here"
        lb.numberOfLines = 0
        return lb
    }()
    
    let releaseDateLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Release Date"
        return lb
    }()
    
    var movie: Movie! {
        didSet {
            titleLabel.text = movie.title
            overviewLabel.text = movie.overview
            releaseDateLabel.text = movie.releaseDate
            if let posterURL = movie.posterURL {
                posterImageView.af_setImage(withURL: posterURL)
            }
            if let backdropURL = movie.backdropURL {
                backdropImageView.af_setImage(withURL: backdropURL)
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.navigationBar.tintColor = .black
        [backdropImageView, posterImageView,
         titleLabel, overviewLabel, releaseDateLabel].forEach({view.addSubview($0)})
        setupAnchors()
    }
    
    func setupAnchors() {
        let margins = view.layoutMarginsGuide
        backdropImageView.anchor(top: margins.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 225)
        posterImageView.anchor(top: nil, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 120, height: 200)
        posterImageView.centerYAnchor.constraint(equalTo: backdropImageView.bottomAnchor).isActive = true
        
        titleLabel.anchor(top: backdropImageView.bottomAnchor, left: posterImageView.rightAnchor, bottom: nil, right: margins.rightAnchor, paddingTop: 8, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        releaseDateLabel.anchor(top: titleLabel.bottomAnchor, left: posterImageView.rightAnchor, bottom: nil, right: margins.rightAnchor, paddingTop: 4, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        overviewLabel.anchor(top: posterImageView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: margins.rightAnchor, paddingTop: 8, paddingLeft: 8, paddingBottom: 0, paddingRight: 4, width: 0, height: 0)
    }
    
}
