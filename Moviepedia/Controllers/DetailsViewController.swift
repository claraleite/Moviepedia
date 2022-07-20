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
    @IBOutlet var genresLabel: UILabel!
    
    var genreArray: [GenreId] = []
    var genreNameArray: [String] = []
    var genresString: String = ""
    
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
        headerImageView.image = UIImage(named: "Group 1")
        posterImageView.image = UIImage(named: "Group 2")
        titleLabel.text = movie.title
        ratingLabel.text = "Rating: \(movie.voteAverage)/10"
        overviewLabel.text = movie.overview
        
        
        Task {
            genreArray = await Movie.genresAPI()
            for item in genreArray {
                if movie.genreIds.contains(item.id) {
                    genreNameArray.append(item.name)
                }
            }
            
            for i in 0..<genreNameArray.count {
                genresString = "\(genresString)\n\(genreNameArray[i])"
            }
            
            genresLabel.text = genresString
            
            print(genresString)
            print(genreArray)
            print(genreNameArray)

        }
        
//        print("Genero vazia \(genreArray)")
//        print(movie.genreIds)
//
//        if movie.genreIds.contains(28) {
//            print("yes")
//            genreNameArray.append("Adventure")
//        }
//
////        for item in genreArray {
////            if movie.genreIds.contains(item.id) {
////                genreNameArray.append(item.name)
////            }
////        }
//        print(genreNameArray)
//        genresLabel.text = genreNameArray[0]
//
//        }
        
    }
   
}

