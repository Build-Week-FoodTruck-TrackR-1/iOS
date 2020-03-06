//
//  WelcomeViewController.swift
//  Food-Truck-TrackR
//
//  Created by Kerby Jean on 3/3/20.
//  Copyright © 2020 Michael. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var operatorChoiceButton: UIButton!
    @IBOutlet weak var foodieChoiceButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateViews()
    }
    
    // MARK: - Functions
    
    @IBAction func ChoiceTapped(_ sender: UIButton) {
        /// Button title as a choice Trucker/Foodie
        
        if sender.tag == 0 {
            performSegue(withIdentifier: Segue.AuthSegue.rawValue, sender: Choice.trucker)
        } else {
            performSegue(withIdentifier: Segue.AuthSegue.rawValue, sender: Choice.foodie)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Segue.AuthSegue.rawValue {
            if let destination = segue.destination as? AuthViewController,  let choice = sender as? Choice {
                destination.choice = choice
            }
        }
    }
    
    func updateViews() {
        logoImageView.image = UIImage(named: "FoodTruck_Logo")
        operatorChoiceButton.backgroundColor = UIColor(#colorLiteral(red: 0.1704146564, green: 0.1961146891, blue: 0.7698651552, alpha: 1))
        operatorChoiceButton.layer.cornerRadius = 8
        foodieChoiceButton.backgroundColor = UIColor(#colorLiteral(red: 0.1704146564, green: 0.1961146891, blue: 0.7698651552, alpha: 1))
        foodieChoiceButton.layer.cornerRadius = 8
    }
}

