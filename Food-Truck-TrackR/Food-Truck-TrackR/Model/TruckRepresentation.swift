//
//  TruckRepresentation.swift
//  Food-Truck-TrackR
//
//  Created by Michael on 3/3/20.
//  Copyright © 2020 Michael. All rights reserved.
//

import Foundation

struct TruckRepresentation: Codable, Equatable {
    var id: UUID
    var name: String
    var image: Data?
    var cuisineType: String
    var address: String
    var customerRatings: [Int64]?
    var ratingAvg: Double?
    var latitude: Double?
    var longitude: Double?
}

