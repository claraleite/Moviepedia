//
//  SeeAllTableViewController.swift
//  Moviepedia
//
//  Created by mccl on 18/07/22.
//

import UIKit

class SeeAllTableViewController: UIViewController {
    
    @IBOutlet var seeAllTableView: UITableView!
    
    var movies: [Movie] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let nib = UINib(nibName: "SeeAllTableViewCell", bundle: nil)
            
        seeAllTableView.register(nib, forCellReuseIdentifier: "SeeAllTableViewCell")
            
        seeAllTableView.delegate = self
        seeAllTableView.dataSource = self
  
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if let destination = segue.destination as? DetailsViewController {
                    let movie = sender as? Movie
                    destination.movie = movie

            }


        }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let selectedIndexPath = seeAllTableView.indexPathForSelectedRow {
               seeAllTableView.deselectRow(at: selectedIndexPath, animated: animated)
           }
    }
}
    


    // MARK: - Table view data source

extension SeeAllTableViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count

    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SeeAllTableViewCell", for: indexPath) as! SeeAllTableViewCell
        
        
        let movie = movies[indexPath.row]
        cell.setup(title: movie.title, image: UIImage(named: "Group 2") ?? UIImage(), year: String(movie.releaseDate.prefix(4)), rate: String(movie.voteAverage))
        
        Task {
            let imageData = await Movie.downloadImageData(withPath: movie.posterPath)
            let imagePoster: UIImage = UIImage(data: imageData) ?? UIImage()
            cell.setup(title: movie.title, image: imagePoster, year: String(movie.releaseDate.prefix(4)), rate: String(movie.voteAverage))
        }

        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie: Movie
        movie = movies[indexPath.row]
        performSegue(withIdentifier: "seeAllToDetailsSegue", sender: movie)
    }

}
