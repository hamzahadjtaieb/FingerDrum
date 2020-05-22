//
//  FirstInsideCollectionViewCell.swift
//  FingerDrum
//
//  Created by Mac on 3/31/20.
//  Copyright © 2020 esprit. All rights reserved.
//

import UIKit

class FirstInsideCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var Titre_NewProd_Colllection_Cell: UILabel!
    
    @IBOutlet weak var Image_NewProd_Collection_Cell: UIImageView!
    
    // 2 - YEs Houni
    static let identifier = "FirstInsideCollectionViewCell"
    
    private var collectionView: UICollectionView?
    private var index: Int?
    
    
    func configure2(with track: Track, collectionView: UICollectionView, index: Int) {
        
        Titre_NewProd_Colllection_Cell.text = track.title
        
        
//        print(event.image)
        Image_NewProd_Collection_Cell.image = UIImage(named: track.image!)
        // descriptionLabel.text = city.description
        
        self.collectionView = collectionView
        self.index = index
    }
    
}
