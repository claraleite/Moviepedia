//
//  ViewController.swift
//  Moviepedia
//
//  Created by mccl on 04/07/22.
//

import UIKit

class FeaturedViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {


    @IBOutlet var popularCollectionView: UICollectionView!
    @IBOutlet var nowPlayingCollectionView: UICollectionView!
    @IBOutlet var upcomingCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        popularCollectionView.dataSource = self
        popularCollectionView.delegate = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "popularCell", for: indexPath) as?    PopularCollectionViewCell
        
        cell?.titleLabel.text = "Doutor Estranho no Multiverso da Loucura"
        cell?.image.image = UIImage(named: "Doutor Estranho no Multiverso da Loucura")
        
        return cell ?? UICollectionViewCell()
    }
    


}

