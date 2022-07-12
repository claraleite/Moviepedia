//
//  FeaturedViewController+UICollectionViewDataSource.swift
//  Moviepedia
//
//  Created by mccl on 12/07/22.
//

import UIKit

extension FeaturedViewController {
    fileprivate func makePopularCell(_ indexPath: IndexPath) -> UICollectionViewCell {
        let cell = popularCollectionView.dequeueReusableCell(withReuseIdentifier: "popularCell", for: indexPath) as?    PopularCollectionViewCell
        
        cell?.titleLabel.text = popularMovies[indexPath.item].title
        cell?.image.image = UIImage(named: popularMovies[indexPath.item].backdrop)
        
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.popularCollectionView {
            return makePopularCell(indexPath)
            
        } else if collectionView == nowPlayingCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NowPlayingCell", for: indexPath) as? NowPlayingCollectionViewCell
            
            cell?.titleLabel.text = nowPlayingMovies[indexPath.item].title
            cell?.image.image = UIImage(named: nowPlayingMovies[indexPath.item].poster)
            cell?.dateLabel.text = nowPlayingMovies[indexPath.item].releaseDate
            
            return cell ?? UICollectionViewCell()

        } else if collectionView == upcomingCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UpcomingCell", for: indexPath) as? UpcomingCollectionViewCell
            
            cell?.titleLabel.text = upcomingMovies[indexPath.item].title
            cell?.image.image = UIImage(named: upcomingMovies[indexPath.item].poster)
            cell?.dateLabel.text = upcomingMovies[indexPath.item].releaseDate
            
            return cell ?? UICollectionViewCell()

        } else {
            return UICollectionViewCell()
        }
    
    


}

}
