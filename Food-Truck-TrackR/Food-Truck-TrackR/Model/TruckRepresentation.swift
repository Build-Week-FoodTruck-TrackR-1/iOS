//
//  TruckRepresentation.swift
//  Food-Truck-TrackR
//
//  Created by Michael on 3/3/20.
//  Copyright © 2020 Michael. All rights reserved.
//

import Foundation

struct TruckRepresentation: Codable {
    var id: Int? = nil
    var name: String
    var image: String
    var cuisineType: String
    var physicalAddress: String
    
    enum TruckKeys: String, CodingKey {
        case id
        case name
        case image
        case cuisingType = "cuising_type"
        case physicalAddress = "physical_address"
    }
}

