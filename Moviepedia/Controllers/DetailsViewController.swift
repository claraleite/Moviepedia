//
//  DetailsViewController.swift
//  Moviepedia
//
//  Created by mccl on 13/07/22.
//

import UIKit

class DetailsViewController: UIViewController {
    
    
    @IBOutlet var headerImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var posterImageView: UIImageView!
    @IBOutlet var ratingLabel: UILabel!
    @IBOutlet var overviewLabel: UILabel!
    
    
    var movie: Movie?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        guard let movie = movie else {
            return
        }
        
        title = movie.title
        headerImageView.image = UIImage(named: movie.backdropPath)
        titleLabel.text = movie.title
        posterImageView.image = UIImage(named: movie.posterPath)
        ratingLabel.text = "Rating: \(movie.voteAverage)/10"
        overviewLabel.text = movie.overview
        
        
    }
    

}
