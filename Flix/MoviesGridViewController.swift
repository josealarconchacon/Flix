//
//  MoviesGridViewController.swift
//  Flix
//
//  Created by Jose Alarcon Chacon on 10/20/19.
//  Copyright © 2019 Jose Alarcon Chacon. All rights reserved.
//

import UIKit
import AlamofireImage
import BonsaiController

class MoviesGridViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var movies = [[String: Any]]()

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        setMoviesGrid()
        collectionVLayout()
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
    
    private func collectionVLayout() {
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumLineSpacing = 4
        layout.minimumInteritemSpacing = 4
        let width = (view.frame.size.width - layout.minimumInteritemSpacing * 2) / 3
        layout.itemSize = CGSize(width: width, height: width * 3 / 2)
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
        cell.layer.borderColor = UIColor.gray.cgColor
        cell.layer.borderWidth = 0.5
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedCell = collectionView.cellForItem(at: indexPath)
        selectedCell?.layer.borderColor = UIColor.gray.cgColor
        selectedCell?.layer.borderWidth = 2
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let viewC = storyBoard.instantiateViewController(withIdentifier: "MovieGridDetailView")
        viewC.transitioningDelegate = self
        viewC.modalPresentationStyle = .custom
        present(viewC, animated: true, completion: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        segue.destination.transitioningDelegate = self
        segue.destination.modalPresentationStyle = .custom
        guard let detailViewController = segue.destination as? MovieGridDetailView,
            let index = collectionView.indexPathsForSelectedItems else {
                return
        }
        detailViewController.movie = movies[index.count]
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let didSelectCell = collectionView.cellForItem(at: indexPath)
        didSelectCell?.layer.borderColor = UIColor.lightGray.cgColor
        didSelectCell?.layer.borderWidth = 0.5
    }
}

extension MoviesGridViewController: BonsaiControllerDelegate {
    func frameOfPresentedView(in containerViewFrame: CGRect) -> CGRect {
            return CGRect(origin: CGPoint(x: 0, y: containerViewFrame.height / 2), size: CGSize(width: containerViewFrame.width, height: containerViewFrame.height / (3/4)))
        }
        
        func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
            return BonsaiController(fromDirection: .bottom, blurEffectStyle: .light, presentedViewController: presented, delegate: self)
        }
}
