//
//  LoginViewController.swift
//  Food-Truck-TrackR
//
//  Created by Kerby Jean on 3/2/20.
//  Copyright © 2020 Michael. All rights reserved.
//

import UIKit

class AuthViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: - Properties
    
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var authButton: UIButton!
    @IBOutlet weak var truckLogoImageView: UIImageView!
    
    var choice = Choice.trucker
    var authStatus = AuthStatus.signUp
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "\(choice)".capitalized
        usernameField.delegate = self
        passwordField.delegate = self
        updateViews()
    }
    
    // MARK: - Functions
    
    @IBAction func authButtonTapped(_ sender: UIButton) {
        authenticateUser()
    }
    
    
    @IBAction func ChoiceValueChanged(_ sender: UISegmentedControl) {
        
        if sender.selectedSegmentIndex == 0 {
            authStatus = .signUp
            authButton.setTitle(authStatus.description, for: .normal)
        } else {
            authStatus = .logIn
            authButton.setTitle(authStatus.description, for: .normal)
        }
    }
    
    
    func authenticateUser() {
        if let username = usernameField.text, !username.isEmpty,
            let pass = passwordField.text, !pass.isEmpty {
            // Verify auth status state
            if authStatus == .signUp {
                goToStoryboard()
            } else {
                //Login user
                goToStoryboard()
            }
        }
    }
    
    func goToStoryboard() {
        if choice == .trucker {
            let storyboard = UIStoryboard(name: Storyboard.Trucker.rawValue, bundle: nil)
            let nav = storyboard.instantiateViewController(withIdentifier: "TruckerNav") as! UINavigationController
            let _ = nav.topViewController as! MyTrucksViewController
            nav.modalPresentationStyle = .fullScreen
            self.navigationController?.present(nav, animated: true, completion: nil)
        } else {
            let storyboard = UIStoryboard(name: Storyboard.Foodie.rawValue, bundle: nil)
            let nav = storyboard.instantiateViewController(withIdentifier: "FoodieNav") as! UINavigationController
            let _ = nav.topViewController as! TrucksAroundViewController
            nav.modalPresentationStyle = .fullScreen
            self.navigationController?.present(nav, animated: true, completion: nil)
        }
    }
    
    func updateViews() {
        self.title = "\(choice)".capitalized
        logoImageView.image = UIImage(named: "FoodTruck_Logo")
        truckLogoImageView.image = UIImage(named: "FoodTruck_Graphic")
        segmentedControl.backgroundColor = UIColor(#colorLiteral(red: 0.9374387264, green: 0.5664566755, blue: 0.2362774611, alpha: 1))
        usernameField.layer.cornerRadius = 8
        passwordField.layer.cornerRadius = 8
        authButton.backgroundColor = #colorLiteral(red: 0.1401111782, green: 0.1605518758, blue: 0.6343507767, alpha: 1)
        authButton.layer.cornerRadius = 8
        
    }
    
    // MARK: - Text Field Delegate Functions
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if usernameField.isEditing {
            usernameField.layer.borderColor = #colorLiteral(red: 0.1401111782, green: 0.1605518758, blue: 0.6343507767, alpha: 1)
            usernameField.layer.borderWidth = 2.0
            passwordField.layer.borderWidth = 1.0
            passwordField.layer.borderColor = UIColor.gray.cgColor
        } else {
            passwordField.layer.borderColor = #colorLiteral(red: 0.1401111782, green: 0.1605518758, blue: 0.6343507767, alpha: 1)
            passwordField.layer.borderWidth = 2.0
            usernameField.layer.borderWidth = 1.0
            usernameField.layer.borderColor = UIColor.gray.cgColor
        }
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        usernameField.layer.borderWidth = 1.0
        usernameField.layer.borderColor = UIColor.gray.cgColor
        passwordField.layer.borderWidth = 1.0
        passwordField.layer.borderColor = UIColor.gray.cgColor
    }
}
