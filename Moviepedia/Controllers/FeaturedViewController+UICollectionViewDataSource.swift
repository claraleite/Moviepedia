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
        
        cell?.setup(title: popularMovies[indexPath.item].title, image: UIImage(named: popularMovies[indexPath.item].backdropPath) ?? UIImage())
        
        
        return cell ?? PopularCollectionViewCell()
    }
    
    fileprivate func makeNowPlayingCell(_ indexPath: IndexPath) -> NowPlayingCollectionViewCell {
        let cell = nowPlayingCollectionView.dequeueReusableCell(withReuseIdentifier: NowPlayingCollectionViewCell.cellIdentifier, for: indexPath) as? NowPlayingCollectionViewCell
        
        let year: String = String(nowPlayingMovies[indexPath.item].releaseDate.prefix(4))

        
        cell?.setup(title: nowPlayingMovies[indexPath.item].title, year: year, image: UIImage(named: nowPlayingMovies[indexPath.item].posterPath) ?? UIImage())
        
        
        return cell ?? NowPlayingCollectionViewCell()
    }
    
    fileprivate func makeUpcomingCell(_ indexPath: IndexPath) -> UpcomingCollectionViewCell {
        let cell = upcomingCollectionView.dequeueReusableCell(withReuseIdentifier: UpcomingCollectionViewCell.cellIdentifier, for: indexPath) as? UpcomingCollectionViewCell
        
        let year: String = String(upcomingMovies[indexPath.item].releaseDate.prefix(4))
        
        cell?.setup(title: upcomingMovies[indexPath.item].title, year: year, image: UIImage(named: upcomingMovies[indexPath.item].posterPath) ?? UIImage())
        
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
