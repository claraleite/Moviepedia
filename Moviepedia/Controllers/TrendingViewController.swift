//
//  TrendingViewController.swift
//  Moviepedia
//
//  Created by mccl on 13/07/22.
//

import UIKit

class TrendingViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var trendingThisWeek: [Movie] = [] //Movie.trendingThisWeekMovies()
    var trendingToday: [Movie] = [] //Movie.trendingTodayMovies()
    var trendingArray: [Movie] = [] // Master array
    
    @IBOutlet var trendingCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        trendingCollectionView.dataSource = self
        trendingCollectionView.delegate = self
        
        Task {
            trendingToday = await Movie.trendingAPI(section: "movie/day")
            trendingArray = trendingToday
            self.trendingCollectionView.reloadData()
        }

   }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if let destination = segue.destination as? DetailsViewController {
                    let movie = sender as? Movie
                    destination.movie = movie

            }


        }

    
    
    @IBAction func trendingChanged(_ sender: UISegmentedControl) {
            switch sender.selectedSegmentIndex {
            case 0: // caso em que o trending é today
                
                Task {
                    trendingToday = await Movie.trendingAPI(section: "movie/day")
                    trendingArray = trendingToday
                    self.trendingCollectionView.reloadData()
                }
                
            
            case 1: // caso em que o trending é o this week
                 
                Task {
                    trendingThisWeek = await Movie.trendingAPI(section: "movie/week")
                    trendingArray = trendingThisWeek
                    self.trendingCollectionView.reloadData()
                }
                
            default:
                print("Entrou no default")
            }
        }
    
    fileprivate func makeTrendingCell(_ indexPath: IndexPath) -> TrendingCollectionViewCell {
        let cell = trendingCollectionView.dequeueReusableCell(withReuseIdentifier: TrendingCollectionViewCell.cellIdentifier, for: indexPath) as? TrendingCollectionViewCell
        
        let year: String = String(trendingArray[indexPath.item].releaseDate.prefix(4))
        let movie = trendingArray[indexPath.item]
        cell?.setup(title: movie.title, year: year, image: UIImage(named: "Group 2") ?? UIImage())
        
        Task {
            let imageData = await Movie.downloadImageData(withPath: movie.posterPath)
            let image: UIImage = UIImage(data: imageData) ?? UIImage()
            cell?.setup(title: movie.title, year: year, image: image)
            
        }
        
        cell?.setup(title: movie.title, year: year, image: UIImage(named: movie.posterPath) ?? UIImage())
        
        
        return cell ?? TrendingCollectionViewCell()
    }
        

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return trendingArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            return makeTrendingCell(indexPath)
            
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie: Movie
        movie = trendingArray[indexPath.item]
        performSegue(withIdentifier: "trendingToDetailsSegue", sender: movie)

    }

}
