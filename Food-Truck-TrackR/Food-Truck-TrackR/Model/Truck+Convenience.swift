//
//  Truck+Convenience.swift
//  Food-Truck-TrackR
//
//  Created by Michael on 3/5/20.
//  Copyright © 2020 Michael. All rights reserved.
//

import Foundation
import CoreData

extension Truck {
    var truckRepresentation: TruckRepresentation? {
        guard
            let id = identifier,
            let name = name,
            let cuisineType = cuisineType,
            let address = address
            else { return nil }
        
        return TruckRepresentation(id: id, name: name, image: image, cuisineType: cuisineType, address: address, customerRatings: customerRatings as? [Int64], ratingAvg: ratingAvg, latitude: latitude, longitude: longitude)
    }
    
    @discardableResult convenience init?(id: UUID, name: String, image: Data?, cuisineType: String, address: String?, customerRatings: [Int64]?, ratingAvg: Double?, latitude: Double?, longitude: Double?, context: NSManagedObjectContext = CoreDataStack.shared.mainContext ) {
        
        guard
            let rating = ratingAvg,
            let long = longitude,
            let lat = latitude
            else { return nil }
        
        self.init(context: context)
        self.identifier = id
        self.name = name
        self.image = image
        self.cuisineType = cuisineType
        self.address = address
        self.customerRatings = customerRatings as NSObject?
        self.ratingAvg = rating
        self.longitude = long
        self.latitude = lat
    }
    
    @discardableResult convenience init?(truckRepresentation: TruckRepresentation,
                                         context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        
       
        
        self.init(id: truckRepresentation.id,
                  name: truckRepresentation.name,
                  image: truckRepresentation.image,
                  cuisineType: truckRepresentation.cuisineType,
                  address: truckRepresentation.address,
                  customerRatings: truckRepresentation.customerRatings,
                  ratingAvg: truckRepresentation.ratingAvg,
                  latitude: truckRepresentation.longitude,
                  longitude: truckRepresentation.latitude,
                  context: context)
    }
}
