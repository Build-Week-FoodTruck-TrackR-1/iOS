//
//  MyTrucksViewController.swift
//  Food-Truck-TrackR
//
//  Created by Kerby Jean on 3/3/20.
//  Copyright © 2020 Michael. All rights reserved.
//

import UIKit

class MyTrucksVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var trucks = [Truck]()

    override func viewDidLoad() {
        super.viewDidLoad()

    }

}

// MARK: - UITableViewDelegate/UITableViewDataSource
extension MyTrucksVC: UITableViewDelegate, UITableViewDataSource {
    
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

