//
//  SeeAllTableViewCell.swift
//  Moviepedia
//
//  Created by mccl on 15/07/22.
//

import UIKit

class SeeAllTableViewCell: UITableViewCell {
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var poster: UIImageView!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var ratingLabel: UILabel!
    
    func setup(title: String, image: UIImage, year: String, rate: String) {
        titleLabel.text = title
        poster.image = image
        dateLabel.text = year
        ratingLabel.text = rate
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
