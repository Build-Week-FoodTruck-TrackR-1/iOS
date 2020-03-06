//
//  CreateTruckViewController.swift
//  Food-Truck-TrackR
//
//  Created by Kerby Jean on 3/3/20.
//  Copyright © 2020 Michael. All rights reserved.
//

import UIKit

class CreateTruckViewController: UIViewController, UITextFieldDelegate {

    
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
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

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
