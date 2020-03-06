//
//  CreateDishViewController.swift
//  Food-Truck-TrackR
//
//  Created by Michael on 3/5/20.
//  Copyright © 2020 Michael. All rights reserved.
//

import UIKit

class CreateDishViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {

    var foodTruckController: FoodTruckController? {
        didSet {
            
        }
    }
    
    var truck: Truck? {
        didSet {
            
        }
    }
    
    @IBOutlet weak var addDishImageView: UIImageView!
    @IBOutlet weak var dishNameTextField: UITextField!
    @IBOutlet weak var dishDesciptionTextView: UITextView!
    @IBOutlet weak var dishPriceTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dishPriceTextField.delegate = self
        dishNameTextField.delegate = self
        dishDesciptionTextView.delegate = self
        updateViews()
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard
            let name = dishNameTextField.text,
            let description = dishDesciptionTextView.text,
            let price = dishPriceTextField.text,
            let truck = truck
            else { return }
        let menuItemRep = MenuItemRepresentation(name: name, price: Double(price)!, description: description, id: UUID(), images: [URL(string: "https://en.wikipedia.org/wiki/Taco#/media/File:001_Tacos_de_carnitas,_carne_asada_y_al_pastor.jpg")!], customerRatings: [5], ratingAvg: 5)
        let newItem = MenuItem(menuItemRepresentation: menuItemRep)!
        foodTruckController?.addMenuItem(for: truck, item: newItem)
        navigationController?.popViewController(animated: true)
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
        dishDesciptionTextView.layer.borderWidth = 1.0
        dishDesciptionTextView.layer.borderColor = UIColor.gray.cgColor
        dishDesciptionTextView.layer.cornerRadius = 8
        dishNameTextField.layer.cornerRadius = 8
        dishPriceTextField.layer.cornerRadius = 8
    }
    
    // MARK: - Text Field Delegate Functions
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if dishNameTextField.isEditing {
            dishNameTextField.layer.borderColor = #colorLiteral(red: 0.1615272164, green: 0.1829770207, blue: 0.7220367789, alpha: 1)
            dishNameTextField.layer.borderWidth = 2.0
            dishPriceTextField.layer.borderColor = UIColor.gray.cgColor
            dishPriceTextField.layer.borderWidth = 1.0
        } else if dishPriceTextField.isEditing {
            dishNameTextField.layer.borderColor = UIColor.gray.cgColor
            dishNameTextField.layer.borderWidth = 1.0
            dishPriceTextField.layer.borderColor = #colorLiteral(red: 0.1615272164, green: 0.1829770207, blue: 0.7220367789, alpha: 1)
            dishPriceTextField.layer.borderWidth = 2.0
        }
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        dishNameTextField.layer.borderColor = UIColor.gray.cgColor
        dishNameTextField.layer.borderWidth = 1.0
        dishPriceTextField.layer.borderColor = UIColor.gray.cgColor
        dishPriceTextField.layer.borderWidth = 1.0
    }
    
    // MARK: - Text View Delegate Functions
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        dishDesciptionTextView.layer.borderColor = #colorLiteral(red: 0.1615272164, green: 0.1829770207, blue: 0.7220367789, alpha: 1)
        dishDesciptionTextView.layer.borderWidth = 2.0
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        dishDesciptionTextView.layer.borderColor = UIColor.gray.cgColor
        dishDesciptionTextView.layer.borderWidth = 1.0
    }
}
