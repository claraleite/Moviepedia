//
//  PopularCollectionViewCell.swift
//  Moviepedia
//
//  Created by mccl on 11/07/22.
//

import UIKit

class PopularCollectionViewCell: UICollectionViewCell {
    
    static let cellIdentifier = "popularCell"
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    
    func setup(title: String, image: UIImage) {
        titleLabel.text = title
        imageView.image = image
    }
    
    
}
