//
//  MenuItemRepresentation.swift
//  Food-Truck-TrackR
//
//  Created by Michael on 3/3/20.
//  Copyright © 2020 Michael. All rights reserved.
//

import Foundation

struct MenuItemRepresentation: Codable {
    var name: String
    var price: Int64
    var description: String?
    var id: Int64? = nil
}
