//
//  TruckRepresentation.swift
//  Food-Truck-TrackR
//
//  Created by Michael on 3/3/20.
//  Copyright © 2020 Michael. All rights reserved.
//

import Foundation

struct TruckRepresentation: Codable, Equatable {
    var id: UUID = UUID()
    var name: String
    var image: Data?
    var cuisineType: String
    var address: String
    var customerRatings: [Double]? = [5]
    var ratingAvg: Double? = 5
}

