//
//  MoviesDetailViewController.swift
//  Flix
//
//  Created by Jose Alarcon Chacon on 10/20/19.
//  Copyright © 2019 Jose Alarcon Chacon. All rights reserved.
//

import AlamofireImage
import UIKit

class MoviesDetailViewController: UIViewController {
    
    @IBOutlet weak var backDropImageView: UIImageView!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var synopsisLabel: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    
    var movie: [String: Any]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setMoviewDetail()
    }
    
    private func setMoviewDetail() {
        titleLabel.text = movie["title"] as? String
        titleLabel.sizeToFit()
        synopsisLabel.text = movie["overview"] as? String
        synopsisLabel.sizeToFit()
        releaseDate.text = "Released on:  \(String(describing: movie["release_date"] as! String))"
        releaseDate.sizeToFit()
        let baseURL = "https://image.tmdb.org/t/p/w185"
        let posterPath = movie["poster_path"] as! String
        let url = URL(string: baseURL + posterPath)
        posterImageView.af_setImage(withURL: url!)
        let backDropBaseURL = "https://image.tmdb.org/t/p/w780"
        let backDropPath = movie["backdrop_path"] as! String
        let backdropUrl = URL(string: backDropBaseURL + backDropPath)
        backDropImageView.af_setImage(withURL: backdropUrl!)
    }
}

