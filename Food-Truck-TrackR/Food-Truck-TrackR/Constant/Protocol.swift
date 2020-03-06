//
//  Protocol.swift
//  Food-Truck-TrackR
//
//  Created by Michael on 3/6/20.
//  Copyright © 2020 Michael. All rights reserved.
//

import Foundation
import MapKit

protocol LocationDataDelegate : NSObjectProtocol {
  func addAnnotation(_ annotations: [PlaceAnnotation])
  func selectedAnnotation(_ title: String)
  func deselectedAnnotation()
  func addRegion(_ region: MKCoordinateRegion)
  func addCenterCoordinate(_ coordinate: CLLocationCoordinate2D)
  func addCamera(_ camera: MKMapCamera)
}
protocol AddTruckViewControllerDelegate: AnyObject {
 func didAddTruck(truck: Truck)
}
