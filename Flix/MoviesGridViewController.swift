//
//  MoviesGridViewController.swift
//  Flix
//
//  Created by Jose Alarcon Chacon on 10/20/19.
//  Copyright © 2019 Jose Alarcon Chacon. All rights reserved.
//

import UIKit
import AlamofireImage

class MoviesGridViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var movies = [[String: Any]]()

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        setMoviesGrid()
    }
    
    private func setMoviesGrid() {
        let url = URL(string: "https://api.themoviedb.org/3/movie/297762/similar?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: .main)
        let task = session.dataTask(with: request) { (data, response, error) in
           if let error = error {
              print(error.localizedDescription)
           } else if let data = data {
              let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
            self.movies = dataDictionary["results"] as! [[String: Any]]
            self.collectionView.reloadData()
            print(self.movies)
           }
        }
        task.resume()
    }
}

extension MoviesGridViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MoviesGridCell", for: indexPath) as! MoviesGridCell
        
        let movie = movies[indexPath.item]
        let baseURL = "https://image.tmdb.org/t/p/w185"
        let posterPath = movie["poster_path"] as! String
        let url = URL(string: baseURL + posterPath)
        cell.moviesGridImage.af_setImage(withURL: url!)
        return cell
    }
}
