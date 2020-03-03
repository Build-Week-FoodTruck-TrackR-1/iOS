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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "\(choice)".capitalized
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
}
