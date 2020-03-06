//
//  TruckService.swift
//  Food-Truck-TrackR
//
//  Created by Kerby Jean on 3/2/20.
//  Copyright © 2020 Michael. All rights reserved.
//
//
//import Foundation
////import FirebaseDatabase
////import CodableFirebase
//
//class TruckService {
//    
//    static let shared = TruckService()
//    
//    typealias completion = Result<Truck?, Error>
//    
//    private var truckReference = Database.database().reference().child("Truck")
//    
//    // Create truck
//    func createTruck(values: [String: Any], completion: @escaping(completion)->()) {
//        truckReference.childByAutoId().updateChildValues(values) { (error, _) in
//            if let error = error {
//                NSLog("Error creating truck: \(error)")
//                completion(.failure(error))
//                return
//            }
//        }
//    }
//    
//    // Update truck
//    func updateTruck(id: String, values: [String: Any]) {
//        truckReference.child(id).updateChildValues(values) { (error, _) in
//            if let error = error {
//                NSLog("Error updating truck: \(error)")
//                return
//            }
//        }
//    }
//    
//    // Delete truck
//    func deleteTruck(id: String) {
//        truckReference.child(id).removeValue { (error, _) in
//            if let error = error {
//                NSLog("Error delete truck: \(error)")
//                return
//            }
//        }
//    }
//}
