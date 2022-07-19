//
//  SearchViewController.swift
//  Moviepedia
//
//  Created by mccl on 19/07/22.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    
    @IBOutlet var guideLabel: UIView!
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var resultsTableView: UITableView!
    
    var allMovies: [Movie] = []
    var filteredData: [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "SearchTableViewCell", bundle: nil)
            
        resultsTableView.register(nib, forCellReuseIdentifier: "SearchTableViewCell")
        
        resultsTableView.delegate = self
        resultsTableView.dataSource = self
        searchBar.delegate = self
        
        filteredData = allMovies

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let selectedIndexPath = resultsTableView.indexPathForSelectedRow {
               resultsTableView.deselectRow(at: selectedIndexPath, animated: animated)
           }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if let destination = segue.destination as? DetailsViewController {
                    let movie = sender as? Movie
                    destination.movie = movie

            }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.count
        }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell", for: indexPath) as! SearchTableViewCell
        
        let movie = filteredData[indexPath.row]
        cell.setup(title: movie.title, image: UIImage(named: "Group 2") ?? UIImage(), year: String(movie.releaseDate.prefix(4)))
        
        Task {
            let imageData = await Movie.downloadImageData(withPath: movie.posterPath)
            let imagePoster: UIImage = UIImage(data: imageData) ?? UIImage()
            cell.setup(title: movie.title, image: imagePoster, year: String(movie.releaseDate.prefix(4)))
        }

        return cell
        
        }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie: Movie
        movie = filteredData[indexPath.row]
        performSegue(withIdentifier: "searchToDetailsSegue", sender: movie)
    }

    // MARK: - Search bar Configuration
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredData = []
        
        Task {
            allMovies = await Movie.searchAPI(section: searchText)
            guideLabel.isHidden = true
            self.resultsTableView.reloadData()
        }
        
        if searchText == "" {
            filteredData = allMovies
        } else {
            for movie in allMovies {
                if movie.title.lowercased().starts(with: searchText.lowercased()) {
                filteredData.append(movie)
                }
            }
            guideLabel.isHidden = true
            self.resultsTableView.reloadData()
        }
            
        
    }
}

