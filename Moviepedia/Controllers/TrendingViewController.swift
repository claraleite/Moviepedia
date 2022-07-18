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
    
    @IBOutlet var trendingCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        trendingCollectionView.dataSource = self
        trendingCollectionView.delegate = self

   }
    @IBAction func trendingChanged(_ sender: UISegmentedControl) {
            switch sender.selectedSegmentIndex {
            case 0: // caso em que o trending é today
                
                Task {
                    trendingToday = await Movie.trendingAPI(section: "movie/day")
                    self.trendingCollectionView.reloadData()
                }
                
            
            case 1: // caso em que o trending é o this week
                 
                Task {
                    trendingThisWeek = await Movie.trendingAPI(section: "movie/week")
                    self.trendingCollectionView.reloadData()
                }
                
                
            default:
                print("Entrou no default")
            }
        }
    
    fileprivate func makeTrendingTodayCell(_ indexPath: IndexPath) -> TrendingCollectionViewCell {
        let cell = trendingCollectionView.dequeueReusableCell(withReuseIdentifier: TrendingCollectionViewCell.cellIdentifier, for: indexPath) as? TrendingCollectionViewCell
        
        let year: String = String(trendingToday[indexPath.item].releaseDate.prefix(4))
        let movie = trendingToday[indexPath.item]
        cell?.setup(title: movie.title, year: year, image: UIImage())
        
        Task {
            let imageData = await Movie.downloadImageData(withPath: movie.posterPath)
            let image: UIImage = UIImage(data: imageData) ?? UIImage()
            cell?.setup(title: movie.title, year: year, image: image)
            
        }
        
        cell?.setup(title: movie.title, year: year, image: UIImage(named: movie.posterPath) ?? UIImage())
        
        
        return cell ?? TrendingCollectionViewCell()
    }
        

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return trendingToday.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return makeTrendingTodayCell(indexPath)
    }
    
    

    

}
