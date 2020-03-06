//
//  MenuItem+Convenience.swift
//  Food-Truck-TrackR
//
//  Created by Michael on 3/5/20.
//  Copyright © 2020 Michael. All rights reserved.
//

import Foundation
import CoreData

extension MenuItem {
    var menuItemRepresentation: MenuItemRepresentation? {
        guard
            let name = name,
            let id = identifier
            else { return nil }
        
        return MenuItemRepresentation(name: name, price: price, description: itemDescription, id: id, images: images as? [Data], customerRatings: customerRatings as? [Double], ratingAvg: ratingAvg)
    }
    
    @discardableResult convenience init?(name: String,
                                        price: Double,
                                        description: String?,
                                        id: UUID,
                                        images: [Data]?,
                                        customerRatings: [Double]?,
                                        ratingAvg: Double?,
                                        context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        
        guard
            let average = ratingAvg,
            let dishDescription = description,
            let itemImages = images,
            let ratings = customerRatings
            else { return nil }
        
        self.init(context: context)
        self.name = name
        self.price = price
        self.itemDescription = dishDescription
        self.identifier = id
        self.images = itemImages as NSObject
        self.customerRatings = ratings as NSObject
        self.ratingAvg = average
    }
    
    @discardableResult convenience init?(menuItemRepresentation: MenuItemRepresentation,
                                         context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        
        self.init(name: menuItemRepresentation.name,
                  price: menuItemRepresentation.price,
                  description: menuItemRepresentation.description,
                  id: menuItemRepresentation.id,
                  images: menuItemRepresentation.images,
                  customerRatings: menuItemRepresentation.customerRatings,
                  ratingAvg: menuItemRepresentation.ratingAvg,
                  context: context)
    }
    
}
