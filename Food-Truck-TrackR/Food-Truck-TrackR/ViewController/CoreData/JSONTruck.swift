//
//  JSONTruck.swift
//  Food-Truck-TrackR
//
//  Created by Nick Nguyen on 3/3/20.
//  Copyright © 2020 Michael. All rights reserved.
//

import UIKit

struct JSONTruck : Codable {
    
    let physicalLocation : String?
    let name: String?
    let longitude : Int64?
    let latitude : Int64?
    let imageOfTruck: Data?
    let customerRatings : [Int64]
    let customerRatingAvg : Int64
    let cusinseType: String?
    let identifier: UUID
}
