//
//  MyTruckCell.swift
//  Food-Truck-TrackR
//
//  Created by Kerby Jean on 3/3/20.
//  Copyright © 2020 Michael. All rights reserved.
//

import UIKit

class MyTruckCell: UITableViewCell {

    
    //MARK:- IBOutlets
    
    @IBOutlet weak var truckImageView: UIImageView! 
      
    
    @IBOutlet weak var cuisineTypeLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var truckNameLabel: UILabel!
    
    static var id: String {
        return String(describing: self)
    }
    
    var truck: Truck? {
        didSet {
            updateViews()
        }
    }
    
    private func updateViews() {
        
     print("update view for the cell ")
        
        if let truck = truck {
            guard let name = truck.name,
                let location = truck.physicalLocation,
                let cuisineType = truck.cuisineType,
                let dataImage = truck.imageOfTruck else { return }
            
            truckNameLabel.text = "Name: \(name)"
            locationLabel.text = "Location:\(location)"
            cuisineTypeLabel.text = "Cuisine Type: \( cuisineType)"
            truckImageView.image = UIImage(data: dataImage)
        }
    }
}
