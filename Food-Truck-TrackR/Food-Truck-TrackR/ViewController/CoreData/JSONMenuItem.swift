//
//  JSONMenuItem.swift
//  Food-Truck-TrackR
//
//  Created by Nick Nguyen on 3/3/20.
//  Copyright © 2020 Michael. All rights reserved.
//

import Foundation
import Foundation

struct JSONMenuItem : Codable  {
    
    let itemPrice: Double?
    let itemPhotos : [Data] // array of images
    let itemName: String?
    let itemDescription: String?
    let customerRatings: [Int64]
    let customerRatingAvg: Int64?
    
}
