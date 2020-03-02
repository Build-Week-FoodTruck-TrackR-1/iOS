//
//  LoginViewController.swift
//  Food-Truck-TrackR
//
//  Created by Michael on 3/1/20.
//  Copyright © 2020 Michael. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    let font = UIFont(name: "BebasNeue-Regular", size: 20)
    let standardMargin: CGFloat = 8
    let labelMargin: CGFloat = 12
    
    @IBOutlet weak var appNameLabel: UILabel!
    @IBOutlet weak var loginImageView: UIImageView!
    private var usernameTextField: UITextField = UITextField()
    private var usernameLabel: UILabel = UILabel()
    private var passwordTextField: UITextField = UITextField()
    private var passwordLabel: UILabel = UILabel()
//    private var appNameLabel: UILabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        updateViews()
        // Do any additional setup after loading the view.
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
        view.addSubview(usernameTextField)
        view.addSubview(usernameLabel)
        view.addSubview(passwordTextField)
        view.addSubview(passwordLabel)
            
        usernameTextField.translatesAutoresizingMaskIntoConstraints = false
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // MARK: - Programatic Constraints
        
        passwordTextField.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -100).isActive = true
        passwordTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        passwordTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        passwordLabel.bottomAnchor.constraint(equalTo: passwordTextField.topAnchor, constant: -2).isActive = true
        passwordLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 35).isActive = true
        passwordLabel.trailingAnchor.constraint(equalTo: passwordTextField.trailingAnchor).isActive = true 
        
        usernameTextField.bottomAnchor.constraint(equalTo: passwordLabel.topAnchor, constant: -standardMargin).isActive = true
        usernameTextField.leadingAnchor.constraint(equalTo: passwordTextField.leadingAnchor).isActive = true
        usernameTextField.trailingAnchor.constraint(equalTo: passwordTextField.trailingAnchor).isActive = true
        usernameTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        usernameLabel.bottomAnchor.constraint(equalTo: usernameTextField.topAnchor, constant: -2).isActive = true
        usernameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 35).isActive = true
        usernameLabel.trailingAnchor.constraint(equalTo: usernameTextField.trailingAnchor).isActive = true

        
        
//        usernameTextField.borderStyle = .roundedRect
        
        usernameLabel.attributedText = NSAttributedString(string: "USERNAME", attributes: [NSAttributedString.Key.foregroundColor: UIColor.red, NSAttributedString.Key.font: font ?? UIFont.systemFont(ofSize: 20)])
        passwordLabel.attributedText = NSAttributedString(string: "PASSWORD", attributes: [NSAttributedString.Key.foregroundColor: UIColor.red, NSAttributedString.Key.font: font ?? UIFont.systemFont(ofSize: 20)])
        usernameTextField.attributedPlaceholder = NSAttributedString(string: "    Enter Username:",
                                                                     attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: font ?? UIFont.systemFont(ofSize: 20)])
        usernameTextField.backgroundColor = UIColor.black
        usernameTextField.textColor = UIColor.white
        usernameTextField.font = font
        usernameTextField.layer.borderColor = UIColor.white.cgColor
        usernameTextField.layer.cornerRadius = 15
        usernameTextField.layer.borderWidth = 2.0
        
            
        usernameTextField.rightViewMode = .always
            
        appNameLabel.numberOfLines = 0
        appNameLabel.text = "Food Truck \nTracker"
        appNameLabel.font = UIFont(name: "Blueline-Paradise", size: 115)
            
        
//        passwordTextField.borderStyle = .roundedRect
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "    Enter Password:",
        attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: font ?? UIFont.systemFont(ofSize: 20)])
        passwordTextField.textColor = UIColor.white
        passwordTextField.font = font
        passwordTextField.backgroundColor = UIColor.black
        passwordTextField.layer.borderColor = UIColor.white.cgColor
        passwordTextField.layer.cornerRadius = 15
        passwordTextField.layer.borderWidth = 2.0
        passwordTextField.isSecureTextEntry = true
//        passwordTextField.rightView = UIImage(named: "eyes-closed")
            
        loginImageView.image = UIImage(named: "NewYorkMapImage")
            
        }
    
}
