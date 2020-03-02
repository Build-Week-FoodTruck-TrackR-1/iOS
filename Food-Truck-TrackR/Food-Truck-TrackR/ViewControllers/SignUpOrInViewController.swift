//
//  SignUpOrInViewController.swift
//  Food-Truck-TrackR
//
//  Created by Michael on 3/1/20.
//  Copyright © 2020 Michael. All rights reserved.
//

import UIKit

class SignUpOrInViewController: UIViewController {

    let font = UIFont(name: "AvenirNextCondensed-DemiBoldItalic", size: 28)
    
    
    @IBOutlet weak var appNameLabel: UILabel!
    @IBOutlet weak var signUpOrInImageView: UIImageView!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    private var appNameLabel2: UILabel = UILabel()
    private var usernameTextField: UITextField = UITextField()
    private var passwordTextField: UITextField = UITextField()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateViews()
        // Do any additional setup after loading the view.
    }
    
    func updateViews() {
        let loginString = NSAttributedString(string: "Log In", attributes: [NSAttributedString.Key.font: font ?? UIFont.systemFont(ofSize: 25), NSAttributedString.Key.foregroundColor: UIColor.black])
        let signUpString = NSAttributedString(string: "Sign Up", attributes: [NSAttributedString.Key.font: font ?? UIFont.systemFont(ofSize: 25), NSAttributedString.Key.foregroundColor: UIColor.black])
        appNameLabel.numberOfLines = 0
        appNameLabel.text = "Food Truck \nTracker"
        appNameLabel.font = UIFont(name: "Blueline-Paradise", size: 115)
        loginButton.layer.cornerRadius = 20
        loginButton.backgroundColor = UIColor.red
        loginButton.setAttributedTitle(loginString, for: .normal)
        loginButton.setTitleColor(UIColor.black, for: .normal)
        loginButton.layer.borderColor = UIColor.black.cgColor
        loginButton.layer.borderWidth = 4.0
        
        signUpButton.layer.cornerRadius = 20
        signUpButton.backgroundColor = UIColor.red
        signUpButton.setAttributedTitle(signUpString, for: .normal)
        signUpButton.setTitleColor(UIColor.black, for: .normal)
        signUpButton.layer.borderColor = UIColor.black.cgColor
        signUpButton.layer.borderWidth = 4.0
        
        signUpOrInImageView.image = UIImage(named: "SFMapImage")
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
