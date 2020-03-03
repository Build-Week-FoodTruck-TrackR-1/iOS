//
//  AddTruckVC.swift
//  Food-Truck-TrackR
//
//  Created by Nick Nguyen on 3/3/20.
//  Copyright © 2020 Michael. All rights reserved.
//

import UIKit

protocol AddTruckVCDelegate: AnyObject {
    func didAddTruck(truck: Truck)
}

class AddTruckVC: UIViewController,  UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    
    var truck: Truck?
    
    //MARK: - IBOutlets
    weak var delegate : AddTruckVCDelegate?
    @IBOutlet weak var truckLocation: UITextField!
    @IBOutlet weak var cuisineType: UITextField!
    @IBOutlet weak var truckImageView: UIImageView! {
        didSet {
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
        
    }
    
   
    
    //MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
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
