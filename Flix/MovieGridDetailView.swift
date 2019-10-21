//
//  MovieGridDetailView.swift
//  Flix
//
//  Created by Jose Alarcon Chacon on 10/20/19.
//  Copyright © 2019 Jose Alarcon Chacon. All rights reserved.
//

import AlamofireImage
import UIKit
import WebKit

class MovieGridDetailView: UIViewController, WKUIDelegate {
    
    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var posterTitle: UILabel!
    @IBOutlet weak var posteroverview: UILabel!
    
    var movie: [String: Any]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        posterTitle.text = movie["original_title"] as? String
        posterTitle.sizeToFit()
        posteroverview.text = movie["overview"] as? String
        posteroverview.sizeToFit()
        let baseURL = "https://image.tmdb.org/t/p/w185"
        let posterPath = movie["poster_path"] as! String
        let url = URL(string: baseURL + posterPath)
        posterView.af_setImage(withURL: url!)
    }
    @IBAction func playTrailerButton(_ sender: UIButton) {
        print("Taped")
        performSegue(withIdentifier: "trailer", sender: sender)
    }
    
    @IBAction func dismissButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
