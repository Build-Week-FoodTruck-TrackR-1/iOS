//
//  MyTruckMenuCell.swift
//  Food-Truck-TrackR
//
//  Created by Nick Nguyen on 3/3/20.
//  Copyright © 2020 Michael. All rights reserved.
//

import UIKit

class MyTruckMenuCell: UITableViewCell {

    
    @IBOutlet weak var menuName: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var foodImageView: UIImageView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
