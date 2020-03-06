//
//  MenuItemRepresentation.swift
//  Food-Truck-TrackR
//
//  Created by Michael on 3/3/20.
//  Copyright © 2020 Michael. All rights reserved.
//

import Foundation

struct MenuItemRepresentation: Codable, Equatable {
    var name: String
    var price: Double
    var description: String?
    var id: UUID
    var images: [URL]?
    var customerRatings: [Double]?
    var ratingAvg: Double?
}
