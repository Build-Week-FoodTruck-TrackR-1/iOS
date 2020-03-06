//
//  CreateTruckViewController.swift
//  Food-Truck-TrackR
//
//  Created by Kerby Jean on 3/3/20.
//  Copyright © 2020 Michael. All rights reserved.
//

import UIKit
import CoreLocation

class CreateTruckViewController: UIViewController, UITextFieldDelegate {

    var foodTruckController: FoodTruckController?
    
    var longitude: CLLocationDegrees?
    var latitude: CLLocationDegrees?
    var coords: CLLocation?
    
    
    
    @IBOutlet weak var addTruckImageView: UIImageView!
    @IBOutlet weak var truckNameTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var cuisineTypeTextField: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        truckNameTextField.delegate = self
        cuisineTypeTextField.delegate = self
        locationTextField.delegate = self
        updateViews()
        addTruckImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleSelectPhoto)))
        
    }
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard
            let name = truckNameTextField.text,
            let cuisineType = cuisineTypeTextField.text,
            let address = locationTextField.text,
            let bearer = foodTruckController?.bearer
            else { return }
        
        getCoordinate(addressString: address) { (location, error) in
            self.longitude = location.longitude
            self.latitude = location.latitude
            
            NSLog("This is the error: \(String(describing: error))")
            NSLog("This is the location: \(location)")
        }
        
        if let data = addTruckImageView.image?.jpegData(compressionQuality: 1.0) {
            let truckRep = TruckRepresentation(id: UUID(), name: name, image: data, cuisineType: cuisineType, address: address, customerRatings: [5], ratingAvg: 5)
            
            let truck = Truck(truckRepresentation: truckRep)!
//            foodTruckController?.addFoodTruck(operatorID: bearer.id, with: truck)
        }
        
        
            
        foodTruckController?.saveToPersistentStore()
//        foodTruckController?.addFoodTruck(operatorID: bearer.id, with: truck)
        NSLog("\(bearer.id)")
        navigationController?.popToRootViewController(animated: true)
    }
    
    func getCoordinate( addressString : String,
                        completionHandler: @escaping(CLLocationCoordinate2D, NSError?) -> Void) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(addressString) { (placemarks, error) in
            if error == nil {
                if let placemark = placemarks?[0] {
                    let location = placemark.location!
                    self.coords = placemark.location!
                    completionHandler(location.coordinate, nil)
    
                    return
                }
            }
                
            completionHandler(kCLLocationCoordinate2DInvalid, error as NSError?)
        }
    }
    
    
    
    @objc private func handleSelectPhoto() {
      let imagePickerController = UIImagePickerController()
      imagePickerController.delegate = self
      imagePickerController.allowsEditing = true
       
      present(imagePickerController, animated: true, completion: nil)
    }

    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MenuSegue" {
            guard let menuVC = segue.destination as? MenuViewController else { return }
            menuVC.foodTruckController = foodTruckController
        }
    }
    

    func updateViews() {
        truckNameTextField.layer.cornerRadius = 8
        cuisineTypeTextField.layer.cornerRadius = 8
        locationTextField.layer.cornerRadius = 8
        addTruckImageView.image = UIImage(named: "FoodTruck_Placeholder-Image")
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if truckNameTextField.isEditing {
            truckNameTextField.layer.borderWidth = 2.0
            truckNameTextField.layer.borderColor = #colorLiteral(red: 0.1401111782, green: 0.1605518758, blue: 0.6343507767, alpha: 1)
            cuisineTypeTextField.layer.borderWidth = 1.0
            cuisineTypeTextField.layer.borderColor = UIColor.gray.cgColor
            locationTextField.layer.borderWidth = 1.0
            locationTextField.layer.borderColor = UIColor.gray.cgColor
        } else if cuisineTypeTextField.isEditing {
            truckNameTextField.layer.borderWidth = 1.0
            truckNameTextField.layer.borderColor = UIColor.gray.cgColor
            cuisineTypeTextField.layer.borderWidth = 2.0
            cuisineTypeTextField.layer.borderColor = #colorLiteral(red: 0.1401111782, green: 0.1605518758, blue: 0.6343507767, alpha: 1)
            locationTextField.layer.borderWidth = 1.0
            locationTextField.layer.borderColor = UIColor.gray.cgColor
        } else if locationTextField.isEditing {
            truckNameTextField.layer.borderWidth = 1.0
            truckNameTextField.layer.borderColor = UIColor.gray.cgColor
            cuisineTypeTextField.layer.borderWidth = 1.0
            cuisineTypeTextField.layer.borderColor = UIColor.gray.cgColor
            locationTextField.layer.borderWidth = 2.0
            locationTextField.layer.borderColor = #colorLiteral(red: 0.1401111782, green: 0.1605518758, blue: 0.6343507767, alpha: 1)
        }
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        truckNameTextField.layer.borderWidth = 1.0
        truckNameTextField.layer.borderColor = UIColor.gray.cgColor
        cuisineTypeTextField.layer.borderWidth = 1.0
        cuisineTypeTextField.layer.borderColor = UIColor.gray.cgColor
        locationTextField.layer.borderWidth = 1.0
        locationTextField.layer.borderColor = UIColor.gray.cgColor
    }
}

extension CreateTruckViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
   
  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    dismiss(animated: true, completion: nil)
  }
   
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
      addTruckImageView.image = editedImage
       
    } else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
      addTruckImageView.image = originalImage
    }
    dismiss(animated: true, completion: nil)
  }
}
