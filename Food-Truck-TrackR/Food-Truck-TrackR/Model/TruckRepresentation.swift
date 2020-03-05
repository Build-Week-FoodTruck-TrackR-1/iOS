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
    var name: String?
    var image: String
    var cuisineType: String
    var physicalAddress: String
}

extension TruckRepresentation: Equatable {
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.name != rhs.name
    }
}

