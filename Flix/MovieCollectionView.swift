//
//  MovieCollectionView.swift
//  Flix
//
//  Created by Jose Alarcon Chacon on 10/17/19.
//  Copyright © 2019 Jose Alarcon Chacon. All rights reserved.
//

import UIKit
import AlamofireImage

class MovieCollectionView: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var movieCollection = [[String: Any]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        setMoviesCollection()
        collectionUI()
    }
    
    private func collectionUI() {
        let layOut = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layOut.sectionInset = UIEdgeInsets(top: 0,left: 5,bottom: 0,right: 5)
        layOut.minimumInteritemSpacing = 5
        layOut.itemSize = CGSize(width: (self.collectionView.frame.size.width - 20) / 2, height: self.collectionView.frame.size.height / 3)
    }
    
    private func setMoviesCollection() {
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: .main)
        let task = session.dataTask(with: request) { (data, response, error) in
           if let error = error {
              print(error.localizedDescription)
           } else if let data = data {
              let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
            self.movieCollection = dataDictionary["results"] as! [[String: Any]]
            self.collectionView.reloadData()
            print(dataDictionary)
           }
        }
        task.resume()
    }
}

extension MovieCollectionView: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieCollection.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! MovieCollectionCell
        let movie = movieCollection[indexPath.row]
        let movieTitle = movie["title"] as! String
        cell.movieTitle.text = movieTitle
        let baseURL = "https://image.tmdb.org/t/p/w185"
        let posterPath = movie["poster_path"] as! String
        let url = URL(string: baseURL + posterPath)
        cell.imageView.af_setImage(withURL: url!)
        cell.layer.borderColor = UIColor.gray.cgColor
        cell.layer.borderWidth = 0.5
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedCell = collectionView.cellForItem(at: indexPath)
        selectedCell?.layer.borderColor = UIColor.gray.cgColor
        selectedCell?.layer.borderWidth = 2
    }
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let didSelectCell = collectionView.cellForItem(at: indexPath)
        didSelectCell?.layer.borderColor = UIColor.lightGray.cgColor
        didSelectCell?.layer.borderWidth = 0.5
    }
}
