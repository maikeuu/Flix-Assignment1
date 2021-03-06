//
//  Movie.swift
//  Flix_Assignment1
//
//  Created by Mike Lin on 2/28/18.
//  Copyright © 2018 Mike Lin. All rights reserved.
//

import Foundation

class Movie {
    //movie string properties
    var title: String = ""
    var overview: String = ""
    var releaseDate: String = ""
    //movie URL properties
    var posterPathString: String?
    var backdropPathString: String?
    
    var posterURL: URL?
    var backdropURL: URL?
    
    let baseURLString = "https://image.tmdb.org/t/p/w500"
    
    init(dictionary: [String : Any]) {
        title = dictionary["title"] as? String ?? "No title"
        overview = dictionary["overview"] as? String ?? "Overview currently unavailabile"
        releaseDate = dictionary["release_date"] as? String ?? "Release date unavailable"
        posterPathString = dictionary["poster_path"] as? String
        backdropPathString = dictionary["backdrop_path"] as? String
        
        if let posterPathString = posterPathString {
                   posterURL = URL(string: baseURLString + posterPathString)
        }
        if let backdropPathString = backdropPathString {
            backdropURL = URL(string: baseURLString + backdropPathString)
        }
    }
    
    class func movies(dictionaries: [[String: Any]]) -> [Movie] {
        var movies: [Movie] = []
        for dictionary in dictionaries {
            let movie = Movie(dictionary: dictionary)
            movies.append(movie)
        }
        
        return movies
    }
}
