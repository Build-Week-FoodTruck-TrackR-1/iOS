//
//  PlaceAnnotation.swift
//  Food-Truck-TrackR
//
//  Created by Michael on 3/6/20.
//  Copyright © 2020 Michael. All rights reserved.
//

import Foundation
import MapKit

class PlaceAnnotation: NSObject, MKAnnotation {
   
  /*
  This property is declared with `@objc dynamic` to meet the API requirement that the coordinate property on all MKAnnotations
  must be KVO compliant.
   */
  @objc dynamic var coordinate: CLLocationCoordinate2D
   
  var title: String?
  var url: URL?
   
  init(coordinate: CLLocationCoordinate2D) {
    self.coordinate = coordinate
    super.init()
  }
}
