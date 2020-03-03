//
//  Protocols.swift
//  Food-Truck-TrackR
//
//  Created by Kerby Jean on 3/3/20.
//  Copyright © 2020 Michael. All rights reserved.
//

import MapKit
import CoreLocation

protocol LocationDataDelegate : NSObjectProtocol {
    func addAnnotation(_ annotations: [PlaceAnnotation])
    func selectedAnnotation(_ title: String)
    func deselectedAnnotation()
    func addRegion(_ region: MKCoordinateRegion)
    func addCenterCoordinate(_ coordinate: CLLocationCoordinate2D)
    func addCamera(_ camera: MKMapCamera)
}
