//
//  MyTrucksViewController.swift
//  Food-Truck-TrackR
//
//  Created by Kerby Jean on 3/3/20.
//  Copyright © 2020 Michael. All rights reserved.
//

import UIKit

class MyTrucksViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var trucks = [Truck]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let api = APIServices()
        let newTruck = TruckRepresentation(name: "Merp Merp", image: "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSuEwzXecCmw7cNrVlsVq1wKv1m6zg_X-LBvXmqoeRLtw3bIJo9", cuisineType: "Mexican-Chinese Fusion")
            
        api.addTruckToOperator(truck: newTruck) { _ in
            print("\(api.trucksByOperator[0].name)")
        }
        
        
    }
}

// MARK: - UITableViewDelegate/UITableViewDataSource
extension MyTrucksViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MyTruckCell.id, for: indexPath) as? MyTruckCell else { return UITableViewCell() }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 112.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

