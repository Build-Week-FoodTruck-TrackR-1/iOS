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
        
            guard let username = usernameField.text, !username.isEmpty, let password = passwordField.text, !password.isEmpty else { return }
            
            let newUserSignUp = Foodie(email: username, password: password)
            let newUserLogin = UserLogin(username: username, password: password)
            if self.choice == Choice.foodie {
                switch authStatus {
                case .signUp:
                    apiServices.dinerSignUp(diner: newUserSignUp) { _ in
                        DispatchQueue.main.async {
                            let alertController = UIAlertController(title: "Sign Up Successful!", message: "Please Log In...", preferredStyle: .alert)
                            let alertAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
                            alertController.addAction(alertAction)
                            self.present(alertController, animated: true) {
                                self.authStatus = .logIn
                                self.segmentedControl.selectedSegmentIndex = 1
                                self.authButton.setTitle("Log In", for: .normal)
                        }
                    }
                }
                case .logIn:
                    apiServices.dinerLogin(diner: newUserLogin) { _ in
                        self.goToStoryboard()
                    }
                }
            } else {
                switch authStatus {
                case .signUp:
                    apiServices.operatorSignUp(truckOperator: newUserSignUp) { _ in
                        DispatchQueue.main.async {
                                let alertController = UIAlertController(title: "Sign Up Successful!", message: "Please Log In...", preferredStyle: .alert)
                                let alertAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
                                alertController.addAction(alertAction)
                                self.present(alertController, animated: true) {
                                    self.authStatus = .logIn
                                    self.segmentedControl.selectedSegmentIndex = 1
                                    self.authButton.setTitle("Log In", for: .normal)
                            }
                        }
                    }
                case .logIn:
                    apiServices.operatorLogin(truckOperator: newUserLogin) { _ in
                        self.goToStoryboard()
                    }
                }
            }
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
        
        
    //    func authenticateUser() {
    //        if let username = usernameField.text, !username.isEmpty,
    //            let pass = passwordField.text, !pass.isEmpty {
    //            // Verify auth status state
    //            if authStatus == .signUp {
    //                goToStoryboard()
    //            } else {
    //                //Login user
    //                goToStoryboard()
    //            }
    //        }
    //    }
        
        func goToStoryboard() {
            if choice == .trucker {
                let storyboard = UIStoryboard(name: Storyboard.Trucker.rawValue, bundle: nil)
                let nav = storyboard.instantiateViewController(withIdentifier: "TruckerNav") as! UINavigationController
                let myTruckVC = nav.topViewController as! MyTrucksViewController
                myTruckVC.apiServices = apiServices
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
    
    let apiServices = APIServices()
}
