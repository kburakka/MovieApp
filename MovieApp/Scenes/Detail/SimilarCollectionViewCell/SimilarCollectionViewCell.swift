//
//  SimilarCollectionViewCell.swift
//  MovieApp
//
//  Created by Burak KAYA on 22.10.2020.
//  Copyright © 2020 Burak KAYA. All rights reserved.
//

import UIKit

class SimilarCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        movieTitle.sizeToFit()
        moviePoster.translatesAutoresizingMaskIntoConstraints = false
        moviePoster.clipsToBounds = true
        moviePoster.layer.cornerRadius = 6
    }
}
