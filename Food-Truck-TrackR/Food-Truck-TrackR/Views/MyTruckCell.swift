//
//  MyTruckCell.swift
//  Food-Truck-TrackR
//
//  Created by Kerby Jean on 3/3/20.
//  Copyright © 2020 Michael. All rights reserved.
//

import UIKit

class MyTruckCell: UITableViewCell {

    @IBOutlet weak var truckImageView: UIImageView!
    @IBOutlet weak var cuisineTypeLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
    static var id: String {
        return String(describing: self)
    }
    
    var truck: Truck? {
        didSet {
            updateViews()
        }
    }
    
    private func updateViews() {
        guard
            let truck = truck,
            let image = truck.image,
            let imageURL = URL(string: "https://media-cdn.tripadvisor.com/media/photo-s/0f/f2/a6/1e/photo0jpg.jpg")
            else { return }
        
        let data = try! Data(contentsOf: imageURL)
        truckImageView.image = UIImage(data: data)
        cuisineTypeLabel.text = truck.cuisineType
        locationLabel.text = truck.address
        ratingLabel.text = "\(truck.ratingAvg) Stars"
        
        
    }
}
