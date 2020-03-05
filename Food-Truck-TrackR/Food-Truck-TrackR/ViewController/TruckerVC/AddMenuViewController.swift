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
    var truck : Truck?
    var menuItem: MenuItem?
  @IBOutlet weak var menuImageView: UIImageView! {
    
    didSet {
        menuImageView.isUserInteractionEnabled = true 
      menuImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleSelectPhoto)))
    }
  }
    
  @IBOutlet weak var menuDescription: UITextView!
    
  @IBOutlet weak var menuName: UITextField! {
    didSet {
      menuName.becomeFirstResponder()
    }
  }
   
   
    @IBOutlet weak var menuPriceTextField: UITextField!
    
  
  @IBAction func saveTapped(_ sender: UIBarButtonItem) {
    // Call delegate
    guard let itemPrice = menuPriceTextField.text ,
        let itemPhoto = menuImageView.image?.pngData() ,
        let itemName = menuName.text else { return }
    guard let price = Double(itemPrice) else { return }
   
   let newMenu  = MenuItem(itemPrice: price ,
                 itemPhotos: [itemPhoto],
                 itemName: itemName,
                 itemDescription: menuDescription.text,
                 customerRatings: [2],
                 customerRatingAvg: 2)
    
    do {
       try CoreDataStack.shared.mainContext.save()
    } catch let err as NSError {
        print(err)
    }
    navigationController?.popViewController(animated: true)
    print("Saving menu...")
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
