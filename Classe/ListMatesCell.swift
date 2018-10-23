//
//  ListMatesCell.swift
//  Classe
//
//  Created by Jason Bourne on 18/10/18.
//  Copyright © 2018 Gianluca Littamè. All rights reserved.
//

import UIKit

class ListMatesCell: UITableViewCell {


    @IBOutlet var starsButton: [UIButton]!
    
    @IBOutlet weak var nameProfile: UILabel!
    @IBOutlet weak var imageProfile: UIImageView!
    static let kIdentifier = "ListMatesCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
import UIKit
class SelectMateCell: UITableViewCell{
    @IBOutlet var starsButton: [UIButton]!
    
    @IBOutlet var nameProfile: UILabel!
    
    
    @IBOutlet var imageProfile: UIImageView!
    
    static let kIdentifier = "SelectMateCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
