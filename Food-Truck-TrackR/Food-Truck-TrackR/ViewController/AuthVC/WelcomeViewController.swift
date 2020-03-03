//
//  WelcomeViewController.swift
//  Food-Truck-TrackR
//
//  Created by Kerby Jean on 3/3/20.
//  Copyright © 2020 Michael. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    
    // MARK: - Functions
    
    @IBAction func ChoiceTapped(_ sender: UIButton) {
        /// Button title as a choice Trucker/Foodie
        
        if sender.tag == 0 {
            performSegue(withIdentifier: Segue.AuthSegue.rawValue, sender: Choice.trucker)
        } else {
            performSegue(withIdentifier: Segue.AuthSegue.rawValue, sender: Choice.trucker)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Segue.AuthSegue.rawValue {
            let destination = segue.destination as! AuthViewController
            if let choice = sender as? Choice {
                destination.choice = choice
            }
        }
    }
}

