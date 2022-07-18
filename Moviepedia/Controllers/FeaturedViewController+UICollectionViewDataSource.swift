//
//  FeaturedViewController+UICollectionViewDataSource.swift
//  Moviepedia
//
//  Created by mccl on 12/07/22.
//

import UIKit

extension FeaturedViewController: UICollectionViewDataSource {
    
    
    fileprivate func makePopularCell(_ indexPath: IndexPath) -> PopularCollectionViewCell {
        let cell = popularCollectionView.dequeueReusableCell(withReuseIdentifier: PopularCollectionViewCell.cellIdentifier, for: indexPath) as? PopularCollectionViewCell
        
        let movie = popularMovies[indexPath.item]
        cell?.setup(title: movie.title, image: UIImage())

        
        Task {
            let imageData = await Movie.downloadImageData(withPath: movie.backdropPath)
            let image: UIImage = UIImage(data: imageData) ?? UIImage()
            cell?.setup(title: movie.title, image: image)
        }
        
        return cell ?? PopularCollectionViewCell()
    }
    
    fileprivate func makeNowPlayingCell(_ indexPath: IndexPath) -> NowPlayingCollectionViewCell {
        let cell = nowPlayingCollectionView.dequeueReusableCell(withReuseIdentifier: NowPlayingCollectionViewCell.cellIdentifier, for: indexPath) as? NowPlayingCollectionViewCell
        
        let year: String = String(nowPlayingMovies[indexPath.item].releaseDate.prefix(4))
        let movie = nowPlayingMovies[indexPath.item]
        cell?.setup(title: movie.title, year: year, image: UIImage())
        
        Task {
            let imageData = await Movie.downloadImageData(withPath: movie.posterPath)
            let image: UIImage = UIImage(data: imageData) ?? UIImage()
            cell?.setup(title: movie.title, year: year, image: image)
            
        }
        
        cell?.setup(title: movie.title, year: year, image: UIImage(named: movie.posterPath) ?? UIImage())
        
        
        return cell ?? NowPlayingCollectionViewCell()
    }
    
    fileprivate func makeUpcomingCell(_ indexPath: IndexPath) -> UpcomingCollectionViewCell {
        let cell = upcomingCollectionView.dequeueReusableCell(withReuseIdentifier: UpcomingCollectionViewCell.cellIdentifier, for: indexPath) as? UpcomingCollectionViewCell
        
        let year: String = String(upcomingMovies[indexPath.item].releaseDate.prefix(4))
        let movie = upcomingMovies[indexPath.item]
        cell?.setup(title: movie.title, year: year, image: UIImage())
        
        Task {
            let imageData = await Movie.downloadImageData(withPath: movie.posterPath)
            let image: UIImage = UIImage(data: imageData) ?? UIImage()
            cell?.setup(title: movie.title, year: year, image: image)
        }
        
        cell?.setup(title: movie.title, year: year, image: UIImage(named: movie.posterPath) ?? UIImage())
        
        return cell ?? UpcomingCollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.popularCollectionView {
            return makePopularCell(indexPath)
            
        } else if collectionView == nowPlayingCollectionView {
            return makeNowPlayingCell(indexPath)

        } else if collectionView == upcomingCollectionView {
            return makeUpcomingCell(indexPath)

        } else {
            return UICollectionViewCell()
        }
    
    


}

}
