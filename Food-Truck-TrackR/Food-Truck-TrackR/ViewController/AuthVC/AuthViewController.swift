//
//  LoginViewController.swift
//  Food-Truck-TrackR
//
//  Created by Kerby Jean on 3/2/20.
//  Copyright © 2020 Michael. All rights reserved.
//

import UIKit

class AuthViewController: UIViewController {
    
    
    // MARK: - Properties
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var authButton: UIButton!
    
    var choice = Choice.trucker
    var authStatus = AuthStatus.signUp
    
    // MARK: - Functions
    
    @IBAction func authButtonTapped(_ sender: UIButton) {
        authenticateUser()
    }
    
    
    @IBAction func ChoiceValueChanged(_ sender: UISegmentedControl) {
        
        if sender.selectedSegmentIndex == 0 {
            authStatus = .signUp
            authButton.setTitle("Sign Up", for: .normal)
        } else {
            authStatus = .signUp
            authButton.setTitle("Log In", for: .normal)
        }
    }
    
    
    func authenticateUser() {
        if let username = usernameField.text, !username.isEmpty,
            let pass = passwordField.text, !pass.isEmpty {
            // Verify auth status state
            if authStatus == .signUp {
                let storyboard = UIStoryboard(name: Storyboard.Foodie.rawValue, bundle: Bundle.main)
                let vc = storyboard.instantiateViewController(identifier: MyTrucksViewController.id) as! MyTrucksViewController
                self.present(vc, animated: true, completion: nil)
            } else {
                //Login user
                let storyboard = UIStoryboard(name: Storyboard.Trucker.rawValue, bundle: Bundle.main)
                let vc = storyboard.instantiateViewController(identifier: MyTrucksViewController.id) as! MyTrucksViewController
                self.present(vc, animated: true, completion: nil)
            }
        }
    }
}
