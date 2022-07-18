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
        
        Task {
            let imageDataPoster = await Movie.downloadImageData(withPath: movie.posterPath)
            let imageDataBackdrop =  await Movie.downloadImageData(withPath: movie.backdropPath)
            let imagePoster: UIImage = UIImage(data: imageDataPoster) ?? UIImage()
            let imageBackdrop: UIImage = UIImage(data: imageDataBackdrop) ?? UIImage()
            headerImageView.image = imageBackdrop
            posterImageView.image = imagePoster
        }
        
        title = movie.title
        titleLabel.text = movie.title
        ratingLabel.text = "Rating: \(movie.voteAverage)/10"
        overviewLabel.text = movie.overview
        
        
    }
    

}
