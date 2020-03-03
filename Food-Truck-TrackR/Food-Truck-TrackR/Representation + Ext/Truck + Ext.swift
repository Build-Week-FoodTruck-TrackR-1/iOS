//
//  Representation + Ext.swift
//  Food-Truck-TrackR
//
//  Created by Nick Nguyen on 3/3/20.
//  Copyright © 2020 Michael. All rights reserved.
//

import Foundation
import CoreData

extension Truck {
    
    var jsonTruck : JSONTruck? {
        guard let cuisineType = cuisineType,
            let customerRatingAvg = customerRatings,
            let customerRatings = customerRatings,
            let imageOfTruck = imageOfTruck,
            let name = name ,
            let physicalLocation = physicalLocation else { return nil }
        
        return JSONTruck(physicalLocation: physicalLocation,
                         name: name,
                         longitude: longitude,
                         latitude: latitude,
                         imageOfTruck: imageOfTruck,
                         customerRatings: customerRatings as! [Int64],
                         customerRatingAvg: customerRatingAvg as! Int64,
                         cusinseType: cuisineType,
                         identifier: identifier ?? UUID())
    }
    
    
     // This creates a new managed object from raw data
    
    @discardableResult convenience init(physicalLocation: String ,
        name: String ,
        longitude :Int64,
        latitude: Int64,
        imageOfTruck: URL,
        customerRatings: [Int64],
        customerRatingAvg: Int64,
        cusinseType: String,
        identifier: UUID = UUID(),
        context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        
        self.init(context:context)
        self.physicalLocation = physicalLocation
        self.name = name
        self.longitude = longitude
        self.latitude = latitude
        self.imageOfTruck = imageOfTruck
        self.customerRatings = customerRatings as NSObject
        self.customerRatingAvg = customerRatingAvg
        self.cuisineType = cusinseType
        self.identifier = identifier
        
    
    }
    
    
    
     // This creates a managed object from  JSON  (which comes from Firebase)
    
    @discardableResult convenience init?(jsonTruck: JSONTruck,context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        guard let physicalLocation = jsonTruck.physicalLocation,
            let name = jsonTruck.name,
            let longitude = jsonTruck.longitude,
            let latitude = jsonTruck.latitude,
            let imageOfTruck = jsonTruck.imageOfTruck ,
            let cuisineType = jsonTruck.cusinseType else { return nil  }
        
        self.init(physicalLocation: physicalLocation,
                  name:name,
                  longitude:longitude,
                  latitude:latitude,
                  imageOfTruck:imageOfTruck,
                  customerRatings:jsonTruck.customerRatings,
                  customerRatingAvg:jsonTruck.customerRatingAvg,
                  cusinseType:cuisineType,
                  identifier:jsonTruck.identifier,
                  context:context)
     
    }
    
   
    
}
