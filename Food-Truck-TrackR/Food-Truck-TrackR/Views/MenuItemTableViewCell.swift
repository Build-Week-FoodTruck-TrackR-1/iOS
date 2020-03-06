//
//  MenuItemTableViewCell.swift
//  Food-Truck-TrackR
//
//  Created by Michael on 3/6/20.
//  Copyright © 2020 Michael. All rights reserved.
//

import UIKit

class MenuItemTableViewCell: UITableViewCell {

    var menuItem: MenuItem? {
        didSet {
            updateViews()
        }
    }
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var itemDescriptionLabel: UILabel!
    @IBOutlet weak var itemPriceLabel: UILabel!
    @IBOutlet weak var itemImageView: UIImageView!
    
    
    func updateViews() {
        guard
            let menuItem = menuItem,
            let image = menuItem.image
            else { return }
        
        
        itemNameLabel.text = menuItem.name
        itemDescriptionLabel.text = menuItem.itemDescription
        itemPriceLabel.text = "\(menuItem.price)"
        itemImageView.image = UIImage(data: image)
    }
}
