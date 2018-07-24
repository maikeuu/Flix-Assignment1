//
//  MovieCell.swift
//  Flix_Assignment1
//
//  Created by Mike Lin on 1/30/18.
//  Copyright © 2018 Mike Lin. All rights reserved.
//

import UIKit
import AlamofireImage

class MovieCell: UITableViewCell {

    
    let titleLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Title"
        lb.font = UIFont.boldSystemFont(ofSize: 18)
        lb.numberOfLines = 0
        lb.sizeToFit()
        return lb
    }()
    
    let overviewLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Overview"
        lb.font = UIFont.init(name: "Arial", size: 14)
        lb.numberOfLines = 0
        return lb
    }()
    
    let posterImageView: UIImageView = {
        let iv = UIImageView()
        iv.layer.cornerRadius = 5
        iv.layer.masksToBounds = true
        return iv
    }()
    
    var movie: Movie! {
        didSet {
            titleLabel.text = movie.title
            overviewLabel.text = movie.overview
            posterImageView.af_setImage(withURL: movie.posterURL!)
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        [titleLabel, overviewLabel, posterImageView].forEach({addSubview($0)})
        posterImageView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: nil, paddingTop: 8, paddingLeft: 8, paddingBottom: 8, paddingRight: 0, width: 124, height: 178)
        titleLabel.anchor(top: topAnchor, left: posterImageView.rightAnchor, bottom: nil, right: rightAnchor, paddingTop: 8, paddingLeft: 8, paddingBottom: 0, paddingRight: 8, width: 0, height: 16)
        overviewLabel.anchor(top: titleLabel.bottomAnchor, left: posterImageView.rightAnchor, bottom: nil, right: rightAnchor, paddingTop: 8, paddingLeft: 8, paddingBottom: 0, paddingRight: 8, width: 0, height: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    

}
