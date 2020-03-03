//
//  AddMenuViewController.swift
//  Food-Truck-TrackR
//
//  Created by Kerby Jean on 3/3/20.
//  Copyright © 2020 Michael. All rights reserved.
//

import UIKit

class AddMenuViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate{
   
  //MARK: - IBOutlets
   
  @IBOutlet weak var menuImageView: UIImageView! {
    
    didSet {
      menuImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleSelectPhoto)))
    }
  }
    
  @IBOutlet weak var menuDescription: UITextView!
    
  @IBOutlet weak var menuName: UITextField! {
    didSet {
      menuName.becomeFirstResponder()
    }
  }
   
   
   
   
  @IBAction func saveTapped(_ sender: UIBarButtonItem) {
    // Call delegate
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
        
       menuImageView.image = editedImage
        
     } else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
       menuImageView.image = originalImage
     }
      
     dismiss(animated: true, completion: nil)
   }
}
