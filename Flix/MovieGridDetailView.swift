//
//  MovieGridDetailView.swift
//  Flix
//
//  Created by Jose Alarcon Chacon on 10/20/19.
//  Copyright © 2019 Jose Alarcon Chacon. All rights reserved.
//

import AlamofireImage
import UIKit

class MovieGridDetailView: UIViewController {
    @IBOutlet weak var posterView: UIImageView!
    
    var movie: [String: Any]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let baseURL = "https://image.tmdb.org/t/p/w185"
        let posterPath = movie["poster_path"] as! String
        let url = URL(string: baseURL + posterPath)
        posterView.af_setImage(withURL: url!)
    }
}
