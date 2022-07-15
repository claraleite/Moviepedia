//
//  TrendingViewController.swift
//  Moviepedia
//
//  Created by mccl on 13/07/22.
//

import UIKit

class TrendingViewController: UIViewController {
    
    let trendingThisWeek = Movie.trendingThisWeekMovies()
    let trendingToday = Movie.trendingTodayMovies()
    
    var movie: Movie?

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    

}
