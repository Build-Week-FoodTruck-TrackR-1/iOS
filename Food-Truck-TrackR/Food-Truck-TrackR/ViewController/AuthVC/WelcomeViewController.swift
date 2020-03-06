//
//  WelcomeViewController.swift
//  Food-Truck-TrackR
//
//  Created by Kerby Jean on 3/3/20.
//  Copyright © 2020 Michael. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    let foodTruckController = FoodTruckController()
    
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var operatorChoiceButton: UIButton!
    @IBOutlet weak var foodieChoiceButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let truck = TruckRepresentation(id: UUID(), name: "My Truck", image: nil, cuisineType: "Food", address: "555 Not Real MadeUpVille, CA 94987", customerRatings: nil, ratingAvg: nil, latitude: nil, longitude: nil)
        foodTruckController.addFoodTruck(with: truck)
        let menuItem = MenuItemRepresentation(name: "Tacos", price: 8.99, description: "Good Tacos", id: UUID(), images: nil, customerRatings: nil, ratingAvg: nil)
        foodTruckController.addMenuItem(item: menuItem)
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

