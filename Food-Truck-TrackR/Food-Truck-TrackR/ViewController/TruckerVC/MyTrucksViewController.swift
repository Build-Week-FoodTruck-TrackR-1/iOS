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
            
            print("DID SET")
            let newTruck = TruckRepresentation(name: "I sell Food", image: "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSuEwzXecCmw7cNrVlsVq1wKv1m6zg_X-LBvXmqoeRLtw3bIJo9", cuisineType: "Mexican", physicalAddress: "555 fake st. Oakland, CA 55555")
            apiServices?.addTruckToOperator(truck: newTruck) { _ in
                
            }
        }
    }
    
    var trucks = [Truck]()

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        let newTruck = TruckRepresentation(name: "I sell Food", image: "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSuEwzXecCmw7cNrVlsVq1wKv1m6zg_X-LBvXmqoeRLtw3bIJo9", cuisineType: "Mexican", physicalAddress: "555 fake st. Oakland, CA 55555")
//        apiServices?.addTruckToOperator(truck: newTruck) { _ in
//            print("\(String(describing: self.apiServices?.trucksByOperator[0].name))")
//        }
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

