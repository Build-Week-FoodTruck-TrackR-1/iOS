//
//  TrucksAroundViewController.swift
//  Food-Truck-TrackR
//
//  Created by Kerby Jean on 3/3/20.
//  Copyright © 2020 Michael. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation


class TrucksAroundViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    var locationController = LocationController()
    var trucks = [TruckRepresentation]()
    
    private enum AnnotationReuseID: String {
        case pin
    }
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationController.locationDataDelegate = self
        locationController.requestLocation()
        locationController.enableLocationServices()
        mapView.setUserTrackingMode(.follow, animated: true)
        mapView.delegate = self
        // Make sure `MKPinAnnotationView` and the reuse identifier is recognized in this map view.
        mapView.register(MKMarkerAnnotationView.self, forAnnotationViewWithReuseIdentifier: AnnotationReuseID.pin.rawValue)
        
        trucks = [TruckRepresentation(id: 1, name: "Food truck", image: "", cuisineType: "", physicalAddress: "")]

        locationController.addAnnotations(trucks: trucks)
    }
}

// MARK: - MKMapViewDelegate

extension TrucksAroundViewController: MKMapViewDelegate {
    
    func mapViewDidFailLoadingMap(_ mapView: MKMapView, withError error: Error) {
        print("Failed to load the map: \(error)")
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotation = annotation as? PlaceAnnotation else { return nil }
        
        // Annotation views should be dequeued from a reuse queue to be efficent.
        let view = mapView.dequeueReusableAnnotationView(withIdentifier: AnnotationReuseID.pin.rawValue, for: annotation) as? MKMarkerAnnotationView
        view?.canShowCallout = true
        return view
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let annotation = view.annotation as? PlaceAnnotation else { return }
        if let url = annotation.url {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        
    }
}

extension TrucksAroundViewController: LocationDataDelegate {
    
    func addAnnotation(_ annotations: [PlaceAnnotation]) {
        print(annotations.count)
        mapView.addAnnotations(annotations)
    }
    
    func selectedAnnotation(_ title: String) {
        
    }
    
    func deselectedAnnotation() {
        
    }
    
    func addRegion(_ region: MKCoordinateRegion) {
        
    }
    
    func addCenterCoordinate(_ coordinate: CLLocationCoordinate2D) {
        
    }
    
    func addCamera(_ camera: MKMapCamera) {
        
    }
}
