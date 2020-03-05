//
//  AddTruckViewController.swift
//  Food-Truck-TrackR
//
//  Created by Kerby Jean on 3/3/20.
//  Copyright © 2020 Michael. All rights reserved.
//

import UIKit
import CoreData

class AddTruckViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
   
  var truck: Truck?
   
  //MARK: - IBOutlets
  weak var delegate : AddTruckViewControllerDelegate?
    
  @IBOutlet weak var truckLocation: UITextField!
  @IBOutlet weak var cuisineType: UITextField!
    @IBOutlet weak var truckImageView: UIImageView! {
        didSet {
            truckImageView.isUserInteractionEnabled =  true
               truckImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleSelectPhoto)))
        }
    }

    
    
  @IBOutlet weak var truckNamTextField: UITextField! {
    didSet {
      truckNamTextField.becomeFirstResponder()
        
    }
  }
   
    
   
  @IBAction func saveTruckTapped(_ sender: UIBarButtonItem) {
  // Call delegate here.
    if let truck = truck {
        delegate?.didAddTruck(truck: truck)
              print("Attemping to edit truck")
        
        truck.name = truckNamTextField.text
        truck.imageOfTruck = truckImageView.image?.pngData()
        truck.cuisineType = cuisineType.text
        truck.physicalLocation = truckLocation.text
        navigationController?.popViewController(animated: true)
      
        do {
            try CoreDataStack.shared.mainContext.save()
        } catch let err as NSError {
            print(err.localizedDescription)
        }
        
    } else {
        guard let address = truckLocation.text,
                  let name = truckNamTextField.text,
                  let cuisinseType = cuisineType.text,
                  let  imageData = truckImageView.image?.jpegData(compressionQuality: 1.0) else { return }
              
              let _ = Truck(physicalLocation:address,
                                name:name,
                                longitude: 0,
                                latitude: 0,
                                imageOfTruck:imageData,
                                customerRatings: [Int64(3)],
                                customerRatingAvg: Int64(3),
                                cusinseType: cuisinseType )

              do  {
                 try CoreDataStack.shared.mainContext.save()
              } catch let error as NSError {
                NSLog("Error creating new Truck", error)
              }
              navigationController?.popViewController(animated: true)

    }
   

  }
   
  
   
  //MARK: - View Life Cycle
   
  override func viewDidLoad() {
    super.viewDidLoad()

  
  }
    
    
      override func viewWillAppear(_ animated: Bool) {
          super.viewWillAppear(animated)
        
          if let truck = truck {
              title = "Edit truck"
              truckNamTextField.text = truck.name
              truckLocation.text = truck.physicalLocation!
              cuisineType.text = truck.cuisineType
              truckImageView.image = UIImage(data: truck.imageOfTruck!)
          }
        
      }
      
   
  //MARK: - Methods:
   
 @objc private func handleSelectPhoto() {
     print("Trying to select photo...")
      
     let imagePickerController = UIImagePickerController()
      
     imagePickerController.delegate = self
     imagePickerController.allowsEditing = true
      
     present(imagePickerController, animated: true, completion: nil)
   }
   
   
  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
     dismiss(animated: true, completion: nil)
   }
    
   func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
      
     if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
        
       truckImageView.image = editedImage
        
     } else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
       truckImageView.image = originalImage
     }
      
     dismiss(animated: true, completion: nil)
      
   }
}


