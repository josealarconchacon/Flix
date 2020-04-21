//
//  ViewController.swift
//  Flix
//
//  Created by Jose Alarcon Chacon on 10/15/19.
//  Copyright © 2019 Jose Alarcon Chacon. All rights reserved.
//

import UIKit
import AlamofireImage

class MoviesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var movies = [[String: Any]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        setMoviesInfo()
        navigationController?.navigationBar.tintColor = .black
        tableView.backgroundColor = .clear
    }
    
    private func setMoviesInfo() {
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: .main)
        let task = session.dataTask(with: request) { (data, response, error) in
           if let error = error {
              print(error.localizedDescription)
           } else if let data = data {
              let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
            self.movies = dataDictionary["results"] as! [[String: Any]]
            self.tableView.reloadData()
            print(dataDictionary)
           }
        }
        task.resume()
    }
}

extension MoviesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell", for: indexPath) as! MovieTableViewCell
        let movie = movies[indexPath.row]
        let movieTitle = movie["title"] as! String
        let movieOverview = movie["overview"] as! String
        cell.movieTitleLabel.text = movieTitle
        cell.movieOverView.text = movieOverview
        let baseURL = "https://image.tmdb.org/t/p/w185"
        let posterPath = movie["poster_path"] as! String
        let url = URL(string: baseURL + posterPath)
        cell.movieImageView.af_setImage(withURL: url!)
        cell.imgCell()
        cell.labelCell()
        cell.cell()
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPath(for: cell)!
        let selectedMovie = movies[indexPath.row]
        let detailVC = segue.destination as! MoviesDetailViewController
        detailVC.movie = selectedMovie
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}

