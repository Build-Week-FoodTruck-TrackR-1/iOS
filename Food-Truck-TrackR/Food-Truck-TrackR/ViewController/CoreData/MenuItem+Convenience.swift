//
//  MenuItem+Convenience.swift
//  Food-Truck-TrackR
//
//  Created by Michael on 3/4/20.
//  Copyright © 2020 Michael. All rights reserved.
//

import Foundation
import CoreData

extension MenuItem {
    
    // This is to turn a Core Data Managed MenuItem into a Menu Item Representation for marshalling to JSON and sending to the server.
    
    var menuItemRepresentation: MenuItemRepresentation? {
        guard let name = name else { return nil }
        
        return MenuItemRepresentation(name: name,
                                      price: Int64(price),
                                      description: description,
                                      id: Int64(identifier))
    }
    
    // This is for creating a new managed object in Core Data
    
    @discardableResult convenience init(id: Int64,
                                        name: String,
                                        price: Double,
                                        itemDescription: String,
                                        context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        
        self.init(context: context)
        self.identifier = id
        self.name = name
        self.price = price
        self.itemDescription = itemDescription
    }
    
    // This is for converting a MenuItemRepresentation (comes from JSON) into a managed object for Core Data
    
    @discardableResult convenience init?(menuItemRepresentation: MenuItemRepresentation,
                                         context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        
        guard
            let id = menuItemRepresentation.id,
            let description = menuItemRepresentation.description
            else { return nil }
        
        self.init(id: id,
                  name: menuItemRepresentation.name,
                  price: Double(menuItemRepresentation.price),
                  itemDescription: description,
                  context: context)
    }
}
