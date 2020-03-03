//
//  MyTruckCell.swift
//  Food-Truck-TrackR
//
//  Created by Kerby Jean on 3/3/20.
//  Copyright © 2020 Michael. All rights reserved.
//

import UIKit

class MyTruckCell: UITableViewCell {

    
    //MARK: - IBOutlets
    
    @IBOutlet weak var truckImageView: UIImageView!
    @IBOutlet weak var cuisineTypeLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
    
    
    
    //MARK:- Propeties
    
    static var id: String {
        return String(describing: self)
    }
    
    var truck: Truck? {
        didSet {
            updateViews()
        }
    }
    
    private func updateViews() {
    
    }
    
    
    
}
