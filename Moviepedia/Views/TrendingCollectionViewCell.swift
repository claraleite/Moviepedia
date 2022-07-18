//
//  TrendingCollectionViewCell.swift
//  Moviepedia
//
//  Created by mccl on 18/07/22.
//

import UIKit

class TrendingCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    
    static let cellIdentifier = "trendingCell"
    
    func setup(title: String, year: String, image: UIImage) {
        titleLabel.text = title
        dateLabel.text = year
        imageView.image = image
    }
    
}
