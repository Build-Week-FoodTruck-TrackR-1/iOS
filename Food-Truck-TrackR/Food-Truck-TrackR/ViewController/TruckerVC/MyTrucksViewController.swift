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
    
    var apiServices: APIServices? {
        didSet {
            
<<<<<<< HEAD
            print("DID SET")
            let newTruck = TruckRepresentation(name: "I sell Food", image: "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSuEwzXecCmw7cNrVlsVq1wKv1m6zg_X-LBvXmqoeRLtw3bIJo9", cuisineType: "Mexican", physicalAddress: "555 fake st. Oakland, CA 55555")
            apiServices?.addTruckToOperator(truck: newTruck) { _ in
                
            }
=======
>>>>>>> 13499e6b4f912cb6c7a714e6b7f6d3dc61b06b34
        }
    }
    
    var trucks = [Truck]()

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        var newTruck2 = TruckRepresentation(id: nil, name: "Rons Food Truck", image: "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSuEwzXecCmw7cNrVlsVq1wKv1m6zg_X-LBvXmqoeRLtw3bIJo9", cuisineType: "Food", physicalAddress: "769 Not Real St. MadeUpVille, CA 94253")
        apiServices?.addTruckToOperator(truck: newTruck2) { _ in
            
        }
        print(apiServices?.trucksByOperator.count as Any)
        print(apiServices?.trucksByOperator.first?.name as Any)
        print(apiServices?.trucksByOperator.first?.id as Any)
        guard let addedTruck = apiServices?.trucksByOperator.first else { return }
        
        let newMenuItem = MenuItemRepresentation(name: "torta de al pastor", price: 8, description: "big sandwich with steak, lettuce, tomtoes, onions, mayo and salsa", id: nil)
        apiServices?.addMenuItem(truck: addedTruck, menuItem: newMenuItem, completion: { _ in
            
        })
        print(apiServices?.trucksByOperator.count as Any)
        print(apiServices?.trucksByOperator.first?.name as Any)
        print(apiServices?.trucksByOperator.first?.id as Any)
        print(apiServices?.menuItemsByTruck.count as Any)
        print(apiServices?.menuItemsByTruck.first?.name as Any)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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

