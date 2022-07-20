//
//  ViewController.swift
//  Moviepedia
//
//  Created by mccl on 04/07/22.
//

import UIKit

class FeaturedViewController: UIViewController {
    
    var popularMovies: [Movie] = [] //Movie.popularMovies()
    var nowPlayingMovies: [Movie] = [] //Movie.nowPlayingMovies()
    var upcomingMovies: [Movie] = [] //Movie.upcomingMovies()
    var romanceMovies: [Movie] = []
    
    @IBOutlet var popularCollectionView: UICollectionView!
    @IBOutlet var nowPlayingCollectionView: UICollectionView!
    @IBOutlet var upcomingCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        popularCollectionView.dataSource = self
        popularCollectionView.delegate = self
        
        nowPlayingCollectionView.dataSource = self
        nowPlayingCollectionView.delegate = self
        
        upcomingCollectionView.dataSource = self
        upcomingCollectionView.delegate = self
        
        Task {
            popularMovies = await Movie.moviesAPI(section: "popular")
            self.popularCollectionView.reloadData()
            
        }
        
        Task {
            nowPlayingMovies = await Movie.moviesAPI(section: "now_playing")
            self.nowPlayingCollectionView.reloadData()
            
        }
        
        Task {
            upcomingMovies = await Movie.moviesAPI(section: "upcoming")
            self.upcomingCollectionView.reloadData()
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DetailsViewController {
            // quando entra no if a gente sabe que é de fato o details
            let movie = sender as? Movie
            destination.movie = movie
        }
        if let destination = segue.destination as? SeeAllTableViewController {
            if segue.identifier == "seeAllPopular" {
                destination.movies = popularMovies
                destination.title = "Popular"
            }
            else if segue.identifier == "seeAllNowPlaying" {
                destination.movies = nowPlayingMovies
                destination.title = "Now Playing"
                
            }
            else {
                destination.movies = upcomingMovies
                destination.title = "Upcoming"
            }
    }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == self.popularCollectionView {
            return popularMovies.count
        } else if collectionView == nowPlayingCollectionView {
            return nowPlayingMovies.count
        } else if collectionView == upcomingCollectionView {
            return upcomingMovies.count
        } else {
            return 0
        }
        
    }
    
    
}
