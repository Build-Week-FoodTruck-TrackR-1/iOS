//
//  Truck+Convenience.swift
//  Food-Truck-TrackR
//
//  Created by Michael on 3/4/20.
//  Copyright © 2020 Michael. All rights reserved.
//

import Foundation
import CoreData

extension Truck {
    
    // This is to turn a Core Data Managed Truck into a TruckRepresentation for marshalling to JSON and sending to the server.
    
    var truckRepresentation: TruckRepresentation? {
        guard
            let name = name,
            let image = image,
            let cuisineType = cuisineType,
            let address = physicalAddress
            else { return nil }
        
        
        return TruckRepresentation(id: Int(identifier), name: name, image: "\(image)", cuisineType: cuisineType, physicalAddress: address)
    }
    
    // This is for creating a new managed object in Core Data
    
    @discardableResult convenience init(id: Int64,
                                        name: String,
                                        image: String,
                                        cuisineType: String,
                                        physicalAddress: String,
                                        context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        self.init(context: context)
        self.identifier = id
        self.name = name
        self.image = URL(string: image)
        self.cuisineType = cuisineType
        self.physicalAddress = physicalAddress
    }
    
    // This is for converting TruckRepresentation (comes from JSON) into a managed object for Core Data
    
    @discardableResult convenience init?(truckRepresentation: TruckRepresentation,
                                        context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        
        guard let id = truckRepresentation.id else { return nil }
        
        self.init(id: Int64(id),
                  name: truckRepresentation.name,
                  image: truckRepresentation.image,
                  cuisineType: truckRepresentation.cuisineType,
                  physicalAddress: truckRepresentation.physicalAddress,
                  context: context)
    }
}
