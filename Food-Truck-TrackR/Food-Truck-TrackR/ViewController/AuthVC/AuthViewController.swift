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
    
   
}
