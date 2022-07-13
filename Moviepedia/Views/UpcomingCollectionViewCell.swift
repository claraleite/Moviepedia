//
//  UpcomingCollectionViewCell.swift
//  Moviepedia
//
//  Created by mccl on 11/07/22.
//

import UIKit

class UpcomingCollectionViewCell: UICollectionViewCell {
    
    static let cellIdentifier = "upcomingCell"
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
}
