//
//  UpcomingTableViewCell.swift
//  MovieApp
//
//  Created by Burak KAYA on 22.10.2020.
//  Copyright © 2020 Burak KAYA. All rights reserved.
//

import UIKit

class UpcomingTableViewCell: UITableViewCell {

    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var movieDescription: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
