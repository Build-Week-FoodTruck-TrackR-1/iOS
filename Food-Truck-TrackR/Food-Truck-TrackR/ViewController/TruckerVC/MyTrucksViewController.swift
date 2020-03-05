//
//  MyTrucksViewController.swift
//  Food-Truck-TrackR
//
//  Created by Kerby Jean on 3/3/20.
//  Copyright © 2020 Michael. All rights reserved.
//

import UIKit
import CoreData

class MyTrucksViewController: UIViewController , AddTruckViewControllerDelegate {
    func didAddTruck(truck: Truck) {
        //
    }
    
    lazy var fetchedResultsController: NSFetchedResultsController<Truck> = {
           let fetchRequest: NSFetchRequest<Truck> = Truck.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: #keyPath(Truck.name) , ascending: true)
           fetchRequest.sortDescriptors = [sortDescriptor]
           let context = CoreDataStack.shared.mainContext
           let frc = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
           frc.delegate = self
           try? frc.performFetch()
           return frc
           
       }()
    
    lazy private var refreshControl : UIRefreshControl = {
           let rf = UIRefreshControl()
           rf.tintColor = .red
           rf.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
           return rf
       }()
       
    
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
             tableView.tableFooterView = UIView()
              tableView.addSubview(refreshControl)
        }
    }

   
    //MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
       
    }
    
      @objc func handleRefresh() {
//   Fetch from sever 
        refreshControl.endRefreshing()
      }
    
    @IBAction func logOutTapped(_ sender: UIBarButtonItem) {
            dismiss(animated: true, completion: nil)
        
    }

}


// MARK: - UITableViewDelegate/UITableViewDataSource
extension MyTrucksViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return fetchedResultsController.sections?.count ?? 0
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
  
    
   func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
           
           let label = UILabel()
           label.text = "No trucks to display. Please add some trucks..."
           label.translatesAutoresizingMaskIntoConstraints = false
           label.font = UIFont.boldSystemFont(ofSize: 15)
           label.textColor = .darkGray
    
           return label
       }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
     func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

                 let delete = deleteAction(at: indexPath)
                 let edit = editAction(at: indexPath)

                 return UISwipeActionsConfiguration(actions: [delete, edit])
             }


        func deleteAction(at indexPath: IndexPath) -> UIContextualAction {
              let delete = UIContextualAction(style: .destructive, title: "Delete") { (_, _, completion) in
                

                let truck = self.fetchedResultsController.object(at: indexPath)
                CoreDataStack.shared.mainContext.delete(truck)
                 completion(true)
                  do {
                    try CoreDataStack.shared.mainContext.save()
                  } catch let deleteErr as NSError {
                      print("Failed to delete company", deleteErr.localizedDescription)
                  }
              }
                 delete.backgroundColor = .red

              return delete
          }

      //MARK: - Edit
          func editAction(at indexPath: IndexPath) -> UIContextualAction {
              let editAction = UIContextualAction(style: .normal, title: "Edit") { (_, _, completion) in
                self.performSegue(withIdentifier: "EditSegue", sender: indexPath)
                 completion(true)
              }
 
              editAction.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
          
              return editAction
          }
       
       func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return fetchedResultsController.fetchedObjects!.count == 0 ? 50 : 0
       }
 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddTruckVC" {
            if let destVC = segue.destination as? AddTruckViewController {
                  destVC.delegate = self
            }
      
        }
            
         else if segue.identifier == "EditSegue" {

            if  let destVC  = segue.destination as? AddTruckViewController {
                    destVC.truck = fetchedResultsController.object(at: sender as! IndexPath)
            }

        } else if segue.identifier == "TruckCellSegue" {
            if let destVC = segue.destination as? MenuTableViewController {
                guard let selectedIndex = tableView.indexPathForSelectedRow else { return }
                destVC.truck =  fetchedResultsController.object(at:selectedIndex)
                
            }
        }

    
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
