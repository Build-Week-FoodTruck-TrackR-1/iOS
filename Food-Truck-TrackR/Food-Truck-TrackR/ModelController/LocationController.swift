//
//  LocationController.swift
//  Food-Truck-TrackR
//
//  Created by Michael on 3/6/20.
//  Copyright © 2020 Michael. All rights reserved.
//

import MapKit
import Foundation
import CoreLocation

class LocationController: NSObject {
   
  var locationManager = CLLocationManager()
  var camera = MKMapCamera()
  weak var locationDataDelegate: LocationDataDelegate?
   
  var trucks: [TruckRepresentation]? {
    didSet {
      for truck in trucks! {
        getCoordinate(address: truck.address ?? "") { (result) in
          if let coordinate = try? result.get() {
            self.coordinate2D = coordinate
          }
        }
      }
    }
  }
   
  dynamic var coordinate2D: CLLocationCoordinate2D? {
    didSet {
      addAnnotations(coordinate: coordinate2D!, trucks: trucks!)
    }
  }
   
  var region: MKCoordinateRegion?
   
  private var localSearch: MKLocalSearch? {
    willSet {
      localSearch?.cancel()
    }
  }
   
  override init() {
    super.init()
    locationManager.delegate = self
  }
   
  // Add annotations
  func addAnnotations(coordinate: CLLocationCoordinate2D, trucks: [TruckRepresentation]) {
     
    let mapItems = trucks.compactMap { (truck) -> MKMapItem? in
      let coordinate = CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude)
      let placemark = MKPlacemark(coordinate: coordinate)
      let mapItem = MKMapItem(placemark: placemark)
      mapItem.name = truck.name
      return mapItem
     }
     
     // Turn the array of MKMapItem objects into an annotation with a title that can be shown on the map.
     let annotations = mapItems.compactMap { (mapItem) -> PlaceAnnotation? in
       guard let coordinate = mapItem.placemark.location?.coordinate else { return nil }
       let annotation = PlaceAnnotation(coordinate: coordinate)
       annotation.title = mapItem.name
       return annotation
    }
     
    self.locationDataDelegate?.addAnnotation(annotations)
    updateMapCamera(heading: 50.0, altitude: 25000.0)
  }
   
   
  // Select individual annotation
  func selectAnnotation(title: String) {
    //    locationDataDelegate?.selectedAnnotation(title)
  }
   
  // Deselect individual annotation
  func deselectAnnotation() {
    //    locationDataDelegate?.deselectedAnnotation()
  }
   
   
  // Update region
  func updateMapRegion(rangeSpan: CLLocationDistance) {
    guard let coordinate = coordinate2D else { return }
    region = MKCoordinateRegion(center: coordinate, latitudinalMeters: rangeSpan, longitudinalMeters: rangeSpan)
    //    locationDataDelegate?.addRegion(region!)
    //    locationDataDelegate?.addCenterCoordinate(coordinate)
    updateMapCamera(heading: 10.0, altitude: 500.0)
  }
   
   
  // Update Camera
   
  func updateMapCamera(heading: CLLocationDirection, altitude: CLLocationDistance) {
    guard let coordinate = coordinate2D else { return }
    camera.centerCoordinate = coordinate
    camera.altitude = altitude
    camera.heading = heading
    camera.pitch = 50.0
    //    locationDataDelegate?.addCamera(camera)
  }
   
   
  // Turn address to coordinate
  func getCoordinate(address: String, completion: @escaping(Result<CLLocationCoordinate2D?, Error>) -> ()) {
    let geocoder = CLGeocoder()
    geocoder.geocodeAddressString(address) { (placemarks, error) in
      if let error = error {
        completion(.failure(error))
        return
      }
      if let coordinate = placemarks?.first?.location?.coordinate {
        completion(.success(coordinate))
      }
    }
  }
}
// MARK: - CLLocationManagerDelegate
extension LocationController: CLLocationManagerDelegate {
   
  func requestLocation() {
    guard CLLocationManager.locationServicesEnabled() else {
      displayLocationServicesDisabledAlert()
      return
    }
     
    let status = CLLocationManager.authorizationStatus()
    guard status != .denied else {
      displayLocationServicesDeniedAlert()
      return
    }
     
    locationManager.requestWhenInUseAuthorization()
    locationManager.requestLocation()
  }
   
  func enableLocationServices() {
    if CLLocationManager.locationServicesEnabled() {
      locationManager.desiredAccuracy = kCLLocationAccuracyBest
      locationManager.startUpdatingLocation()
    }
  }
   
  func disableLocationServices() {
    locationManager.stopUpdatingLocation()
  }
   
  func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    switch status {
    case .authorizedWhenInUse:
      print("Authorized")
    case .denied, .restricted:
      print("Not Authorize")
    default:
      break
    }
  }
   
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    if let location = locations.last {
      coordinate2D = location.coordinate
      updateMapRegion(rangeSpan: 100.0)
      disableLocationServices()
    }
  }
   
  func locationManager(_ manager: CLLocationManager, didFailWithError error: Swift.Error) {
     
  }
}
extension LocationController {
   
  private func displayLocationServicesDisabledAlert() {
    let message = NSLocalizedString("LOCATION_SERVICES_DISABLED", comment: "Location services are disabled")
    let alertController = UIAlertController(title: NSLocalizedString("LOCATION_SERVICES_ALERT_TITLE", comment: "Location services alert title"),
                        message: message,
                        preferredStyle: .alert)
    alertController.addAction(UIAlertAction(title: NSLocalizedString("BUTTON_OK", comment: "OK alert button"), style: .default, handler: nil))
    displayAlert(alertController)
  }
   
  private func displayLocationServicesDeniedAlert() {
    let message = NSLocalizedString("LOCATION_SERVICES_DENIED", comment: "Location services are denied")
    let alertController = UIAlertController(title: NSLocalizedString("LOCATION_SERVICES_ALERT_TITLE", comment: "Location services alert title"),
                        message: message,
                        preferredStyle: .alert)
    let settingsButtonTitle = NSLocalizedString("BUTTON_SETTINGS", comment: "Settings alert button")
    let openSettingsAction = UIAlertAction(title: settingsButtonTitle, style: .default) { (_) in
      if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
        // Take the user to the Settings app to change permissions.
        UIApplication.shared.open(settingsURL, options: [:], completionHandler: nil)
      }
    }
     
    let cancelButtonTitle = NSLocalizedString("BUTTON_CANCEL", comment: "Location denied cancel button")
    let cancelAction = UIAlertAction(title: cancelButtonTitle, style: .cancel, handler: nil)
     
    alertController.addAction(cancelAction)
    alertController.addAction(openSettingsAction)
    displayAlert(alertController)
  }
   
  private func displayAlert(_ controller: UIAlertController) {
    guard let viewController = UIApplication.shared.windows.first?.rootViewController else {
      fatalError("The key window did not have a root view controller")
    }
    viewController.present(controller, animated: true, completion: nil)
  }
}
