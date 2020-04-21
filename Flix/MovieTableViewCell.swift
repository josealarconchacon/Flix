//
//  MovieTableViewCell.swift
//  Flix
//
//  Created by Jose Alarcon Chacon on 10/15/19.
//  Copyright © 2019 Jose Alarcon Chacon. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieOverView: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func imgCell() {
        movieImageView.layer.cornerRadius = 20
        movieImageView.layer.borderColor = UIColor.lightGray.cgColor
        movieImageView.layer.shadowRadius = 10
        movieImageView.layer.shadowOpacity = 5
     }
    func labelCell() {
        movieTitleLabel.font = UIFont(name: "Open Sans", size: 60)
        movieOverView.font = UIFont(name: "Open Sans", size: 30)
    }
}
