//
//  FoodTruckDetailViewController.swift
//  Food-Truck-TrackR
//
//  Created by Michael on 3/6/20.
//  Copyright © 2020 Michael. All rights reserved.
//

import UIKit
import CoreData

class FoodTruckDetailViewController: UITableViewController {
    
    lazy var fetchedResultsController: NSFetchedResultsController<MenuItem> = {
        let fetchRequest: NSFetchRequest<MenuItem> = MenuItem.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true), NSSortDescriptor(key: "price", ascending: true)]
        let context = CoreDataStack.shared.mainContext
        let frc = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: "name", cacheName: nil)
        frc.delegate = self
        try! frc.performFetch()
        return frc
    }()

    var truck: TruckRepresentation?
    
    
    @IBOutlet weak var truckImageView: UIImageView!
    @IBOutlet weak var truckNameLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        self.title = truck?.name
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "MenuDetailCell")
    }
    

    override func numberOfSections(in tableView: UITableView) -> Int {
    
        return fetchedResultsController.sections?.count ?? 1
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return fetchedResultsController.sections?[section].numberOfObjects ?? 0
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: "MenuDetailCell", for: indexPath)
       let menuItem = fetchedResultsController.object(at: indexPath)
        cell.textLabel?.text = menuItem.name
     cell.detailTextLabel?.text = "\(menuItem.price)"
                  return cell
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

extension FoodTruckDetailViewController: NSFetchedResultsControllerDelegate {
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
        }
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
        }
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        switch type {
        case .insert:
            tableView.insertSections(IndexSet(integer: sectionIndex), with: .automatic)
        case .delete:
            tableView.deleteSections(IndexSet(integer: sectionIndex), with: .automatic)
        default:
            break
        }
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            guard let newIndexPath = newIndexPath else { return }
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        case .update:
            guard let indexPath = indexPath else { return }
            tableView.reloadRows(at: [indexPath], with: .automatic)
        case .move:
            guard let oldIndexPath = indexPath,
                let newIndexPath = newIndexPath else { return }
            tableView.deleteRows(at: [oldIndexPath], with: .automatic)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        case .delete:
            guard let indexPath = indexPath else { return }
            tableView.deleteRows(at: [indexPath], with: .automatic)
        @unknown default:
            break
        }
    }
}