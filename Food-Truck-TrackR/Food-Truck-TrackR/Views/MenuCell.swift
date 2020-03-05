//
//  MenuCell.swift
//  Food-Truck-TrackR
//
//  Created by Kerby Jean on 3/3/20.
//  Copyright © 2020 Michael. All rights reserved.
//

import UIKit

class MenuCell: UITableViewCell {

    //MARK:- IBOutlets
    
    @IBOutlet weak var menuImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    static var id: String {
        return String(describing: self)
    }
    
    var menu: MenuItem? {
        didSet {
            updateViews()
        }
    }
    
    private func updateViews() {
        if let menu = menu {
            nameLabel.text = menu.itemName
            descriptionLabel.text = menu.itemDescription
            priceLabel.text = String(menu.itemPrice)
            
        }
    }
}
