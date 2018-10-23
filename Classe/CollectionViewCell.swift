//
//  CollectionViewCell.swift
//  Classe
//
//  Created by Jason Bourne on 20/10/18.
//  Copyright © 2018 Gianluca Littamè. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

    
    @IBOutlet var imageProfile: UIImageView!
    @IBOutlet var nameProfile: UILabel!
    static let kIdentifier = "CollectionViewCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
