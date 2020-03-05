//
//  MenuItem + Ext.swift
//  Food-Truck-TrackR
//
//  Created by Nick Nguyen on 3/3/20.
//  Copyright © 2020 Michael. All rights reserved.
//

import Foundation
import CoreData

//extension MenuItem {
//    
//    
//    var jsonMenuItem: JSONMenuItem? {
//        guard let itemPhotos = itemPhotos as? [URL], let customerRatings = customerRatings as? [Int64] else { return nil }
//    
//        return JSONMenuItem(itemPrice: itemPrice,
//                            itemPhotos:itemPhotos,
//                            itemName: itemName,
//                            itemDescription: itemDescription,
//                            customerRatings: customerRatings,
//                            customerRatingAvg: customerRatingAvg)
//        
//    }
//    
//    
//    
//    
//     // This creates a new managed object from raw data
//    @discardableResult convenience init(itemPrice: Double, itemPhotos: [URL], itemName: String, itemDescription: String,customerRatings: [Int64], customerRatingAvg: Int64, context: NSManagedObjectContext = CoreDataStack.shared.mainContext ) {
//        
//        self.init(context:context)
//        self.itemPrice = itemPrice
//        self.itemPhotos = itemPhotos as NSObject
//        self.itemName = itemName
//        self.itemDescription = itemDescription
//        self.customerRatings = customerRatings as NSObject
//        self.customerRatingAvg = customerRatingAvg
//    }
    
    
    

    // This creates a managed object from  JSON  (which comes from Firebase)
    
    
//    @discardableResult convenience init?(jsonMenuItem: JSONMenuItem, context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
//        
//        guard let itemPrice = jsonMenuItem.itemPrice ,
//            let itemName = jsonMenuItem.itemName,
//            let itemDescription = jsonMenuItem.itemDescription,
//            let customerRatingAvg = jsonMenuItem.customerRatingAvg else { return nil }
//        
//        
//        self.init(itemPrice:itemPrice,
//                  itemPhotos:jsonMenuItem.itemPhotos,
//                  itemName:  itemName,
//                  itemDescription: itemDescription,
//                  customerRatings: jsonMenuItem.customerRatings,
//                  customerRatingAvg:customerRatingAvg,
//                  context:context)
//        
//    }
//}
