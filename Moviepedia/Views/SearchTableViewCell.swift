//
//  SearchTableViewCell.swift
//  Moviepedia
//
//  Created by mccl on 19/07/22.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    
    
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var imagePoster: UIImageView!
    
    func setup(title: String, image: UIImage, year: String) {
        titleLabel.text = title
        imagePoster.image = image
        dateLabel.text = year
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
