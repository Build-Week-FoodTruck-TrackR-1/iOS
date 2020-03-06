//
//  MyTrucksViewController.swift
//  Food-Truck-TrackR
//
//  Created by Kerby Jean on 3/3/20.
//  Copyright © 2020 Michael. All rights reserved.
//

import UIKit
import CoreData

class MyTrucksViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var foodTruckController: FoodTruckController? {
        didSet {
            guard let bearer = foodTruckController?.bearer else { return }
            foodTruckController?.fetchTrucksByOperator(operatorID: bearer.id, completion: {
                self.tableView.reloadData()
            })
            NSLog("\(String(describing: fetchedResultsController.fetchedObjects?.count))")
        }
    }
    
    lazy var fetchedResultsController: NSFetchedResultsController<Truck> = {
        let fetchRequest: NSFetchRequest<Truck> = Truck.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true), NSSortDescriptor(key: "cuisineType", ascending: true)]
        let context = CoreDataStack.shared.mainContext
        let frc = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: "name", cacheName: nil)
        frc.delegate = self
        try! frc.performFetch()
        return frc
    }()

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        NSLog("\(String(describing: fetchedResultsController.fetchedObjects?.count))")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        

    }
    
    @IBAction func logOutButtonTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: Storyboard.Auth.rawValue, bundle: nil)
        let nav = storyboard.instantiateViewController(withIdentifier: "AuthNav") as! UINavigationController
        let _ = nav.topViewController as! WelcomeViewController
        nav.modalPresentationStyle = .fullScreen
        self.navigationController?.present(nav, animated: true, completion: nil)
    }
    
    
    // MARK: - Navigation

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddTruckVC" {
            guard let createTruckVC = segue.destination as? CreateTruckViewController else { return }
            createTruckVC.foodTruckController = foodTruckController
        } else if segue.identifier == "MenuSegue" {
            guard
                let menuVC = segue.destination as? MenuViewController,
                let indexPath = tableView.indexPathForSelectedRow
                else { return }
            let truck = fetchedResultsController.object(at: indexPath)
            menuVC.truck = truck
        }
    }
    

}

// MARK: - UITableViewDelegate/UITableViewDataSource

extension MyTrucksViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return fetchedResultsController.sections?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultsController.sections?[section].numberOfObjects ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MyTruckCell.id, for: indexPath) as? MyTruckCell else { return UITableViewCell() }
        let truck = fetchedResultsController.object(at: indexPath)
        cell.truck = truck
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        if editingS
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 112.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension MyTrucksViewController: NSFetchedResultsControllerDelegate {
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
