//
//  FoodTruckController.swift
//  Food-Truck-TrackR
//
//  Created by Michael on 3/5/20.
//  Copyright © 2020 Michael. All rights reserved.
//

import Foundation
import Firebase
import CodableFirebase

enum HTTPMethod: String {
    case get = "GET"
    case put = "PUT"
    case post = "POST"
    case delete = "DELETE"
}

class FoodTruckController {
    
    private let baseURL = URL(string: "https://foodtrucktrackr.herokuapp.com/api/")!
    
    var bearer: Bearer?
    
    let truckRef: DatabaseReference = Database.database().reference().child("Truck")
    
    let menuItemRef: DatabaseReference = Database.database().reference().child("MenuItem")
    
    var isUserLoggedIn: Bool {
        if bearer == nil {
            return false
        } else {
            return true
        }
    }
    
    var trucks: [TruckRepresentation] = []
    
    var menuItems: [MenuItemRepresentation] = []
    
    func fetchTrucksByOperator(operatorID: Int, completion: @escaping () -> ()) {
        guard let bearer = bearer else { return }
        truckRef.child("\(bearer.id)").observeSingleEvent(of: .value, with: { snapshot in
            guard let value = snapshot.value else { return }
            let context = CoreDataStack.shared.container.newBackgroundContext()
            
            context.perform {
                do {
                    let fetchedTrucks = Array(try FirebaseDecoder().decode([String : TruckRepresentation].self, from: value).values)
                    self.trucks = fetchedTrucks
                    
                    for truckRep in self.trucks {
                        _ = Truck(truckRepresentation: truckRep, context: context)
                        try context.save()
//                        self.saveToPersistentStore()
                    }
                    DispatchQueue.main.async {
                        completion()
                    }
                } catch let error {
                    NSLog("Error decoding Truck Objects: \(error)")
                    DispatchQueue.main.async {
                        completion()
                    }
                    return
                }
            }
        })
    }
    
    func fetchMenuItemsByTruck(truck: Truck, completion: @escaping () -> ()) {
        guard let truckID = truck.identifier else { return }
        menuItemRef.child("\(truckID)").observeSingleEvent(of: .value) { snapshot in
            guard let value = snapshot.value else { return }
            
            let context = CoreDataStack.shared.container.newBackgroundContext()
            context.perform {
                do {
                    let fetchedMenuItems = Array(try FirebaseDecoder().decode([String : MenuItemRepresentation].self, from: value).values)
                    self.menuItems = fetchedMenuItems
                    
                    for item in self.menuItems {
                        _ = MenuItem(menuItemRepresentation: item, context: context)
                        try context.save()
                    }
                    
                    DispatchQueue.main.async {
                        completion()
                    }
                } catch {
                    NSLog("Error decoding MenuItem Objects: \(error)")
                    DispatchQueue.main.async {
                        completion()
                    }
                    return
                }
            }
        }
    }
    
    func addFoodTruck(operatorID: Int, with truck: Truck) {
        guard let truckRep = truck.truckRepresentation else { return }
        trucks.append(truckRep)
        let data = try! FirebaseEncoder().encode(truckRep)
        self.truckRef.child("\(operatorID)").child("\(truckRep.id)").setValue(data) {
            (error: Error?, ref: DatabaseReference) in
            if let error = error {
                NSLog("Truck could not be saved: \(error) for \(ref)")
            } else {
                NSLog("Truck saved successfully in \(ref)")
                
            }
        }
    }
    
    func deleteFoodTruck(for truck: Truck) {
        guard
            let truckRep = truck.truckRepresentation,
            let truckToDelete = trucks.firstIndex(of: truckRep)
            else { return }
        trucks.remove(at: truckToDelete)
        truckRef.child("\(truckRep.id)").removeValue()
    }
    
    func test(item: MenuItemRepresentation) {
        let data = try! FirebaseEncoder().encode(item)
        menuItemRef.child("\(item.id)").setValue(data)
        NSLog("\(data)")
    }
    
    func addMenuItem(truck: TruckRepresentation, item: MenuItemRepresentation) {
        menuItems.append(item)
        
        let data = try! FirebaseEncoder().encode(item)
        self.menuItemRef.child("\(truck.id)").child("\(item.id)").setValue(data) {
            (error: Error?, ref: DatabaseReference) in
            if let error = error {
                NSLog("Menu Item could not be save: \(error) for \(ref)")
            } else {
                NSLog("Menu Item saved successfully in \(ref)")
            }
        }
    }
    
    func addMenuItem(item: MenuItem) {
        guard let menuItemRep = item.menuItemRepresentation else { return }

        let data = try! FirebaseEncoder().encode(menuItemRep)
        self.menuItemRef.child("\(menuItemRep.id )").setValue(data) {
            (error: Error?, ref: DatabaseReference) in
            if let error = error {
                NSLog("Menu Item could not be save: \(error) for \(ref)")
            } else {
                NSLog("Menu Item saved successfully in \(ref)")
            }
        }
    }
    
    func deleteMenuItem(item: MenuItem) {
        guard
            let menuItemRep = item.menuItemRepresentation,
            let itemToDelete = menuItems.firstIndex(of: menuItemRep)
            else { return }
        
        menuItems.remove(at: itemToDelete)
        menuItemRef.child("\(menuItemRep.id)").removeValue()
    }
    
    func operatorSignUp(truckOperator: Foodie, completion: @escaping (Error?) -> Void) {
        let registerOperatorURL = baseURL.appendingPathComponent("auth/register/operators")
        
        var request = URLRequest(url: registerOperatorURL)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let jsonOperatorSignUpData = try JSONEncoder().encode(truckOperator)
            request.httpBody = jsonOperatorSignUpData
        } catch {
            NSLog("Error Encoding Truck Operator User Object: \(error)")
            completion(error)
            return
        }
        
        URLSession.shared.dataTask(with: request) { (_, response, error) in
            if let response = response as? HTTPURLResponse, response.statusCode != 201 {
                NSLog("HTTP URL Truck Operator Registration Response: \(response)")
                DispatchQueue.main.async {
                    completion(NSError(domain: "", code: response.statusCode, userInfo: nil))
                }
                return
            }
            if let error = error {
                NSLog("Error with Truck Operator Registration: \(error)")
                DispatchQueue.main.async {
                    completion(error)
                }
                return
            }
            DispatchQueue.main.async {
                completion(nil)
            }
        }.resume()
    }
    
    func operatorLogin(truckOperator: UserLogin, completion: @escaping (Error?) -> Void) {
        let operatorLoginURL = baseURL.appendingPathComponent("auth/login/operators")
        
        var request = URLRequest(url: operatorLoginURL)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let jsonOperatorLoginData = try JSONEncoder().encode(truckOperator)
            request.httpBody = jsonOperatorLoginData
        } catch {
            NSLog("Error Encoding Truck Operator Login Object: \(error)")
            completion(error)
            return
        }
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let response = response as? HTTPURLResponse, response.statusCode != 200 {
                NSLog("HTTP URL Truck Operator Login Response: \(response)")
                DispatchQueue.main.async {
                    completion(NSError(domain: "", code: response.statusCode, userInfo: nil))
                }
                return
            }
            if let error = error {
                DispatchQueue.main.async {
                    completion(error)
                }
                return
            }
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(NSError())
                }
                return
            }
            do {
                let decoder = JSONDecoder()
                self.bearer = try decoder.decode(Bearer.self, from: data)
            } catch {
                NSLog("Error Decoding Bearer Object for Truck Operator: \(error)")
                DispatchQueue.main.async {
                    completion(error)
                }
                return
            }
            DispatchQueue.main.async {
                completion(nil)
            }
        }.resume()
    }
    
    func dinerSignUp(diner: Foodie, completion: @escaping (Error?) -> Void) {
        let dinerSignUpURL = baseURL.appendingPathComponent("auth/register/diners")
        
        var request = URLRequest(url: dinerSignUpURL)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let jsonDinerSignUpData = try JSONEncoder().encode(diner)
            request.httpBody = jsonDinerSignUpData
        } catch {
            NSLog("Error Encoding Diner User Object: \(error)")
            completion(error)
            return
        }
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let response = response as? HTTPURLResponse, response.statusCode != 201 {
                NSLog("HTTP URL Diner Registration Response: \(response)")
                DispatchQueue.main.async {
                    completion(NSError(domain: "", code: response.statusCode, userInfo: nil))
                }
                return
            }
            if let error = error {
                NSLog("Error with Diner Registration: \(error)")
                DispatchQueue.main.async {
                    completion(error)
                }
                return
            }
            DispatchQueue.main.async {
                completion(nil)
            }
        }.resume()
    }
    
    func dinerLogin(diner: UserLogin, completion: @escaping (Error?) -> Void) {
        let dinerLoginURL = baseURL.appendingPathComponent("auth/login/diners")
        
        var request = URLRequest(url: dinerLoginURL)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let jsonDinerLoginData = try JSONEncoder().encode(diner)
            request.httpBody = jsonDinerLoginData
        } catch {
            NSLog("Error Encoding Diner Login Object: \(error)")
            completion(error)
            return
        }
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let response = response as? HTTPURLResponse, response.statusCode != 200 {
                NSLog("HTTP URL Diner Login Response: \(response)")
                DispatchQueue.main.async {
                    completion(NSError(domain: "", code: response.statusCode, userInfo: nil))
                }
                return
            }
            if let error = error {
                DispatchQueue.main.async {
                    completion(error)
                }
                return
            }
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(NSError())
                }
                return
            }
            
            do {
                self.bearer = try JSONDecoder().decode(Bearer.self, from: data)
            } catch {
                NSLog("Error Decoding Bearer Object for Diner: \(error)")
                DispatchQueue.main.async {
                    completion(error)
                }
                return
            }
            DispatchQueue.main.async {
                completion(nil)
            }
        }.resume()
    }
    
    func saveToPersistentStore() {
        do {
            try CoreDataStack.shared.save()
        } catch {
            NSLog("Error Saving Managed Object Context: \(error)")
            CoreDataStack.shared.mainContext.reset()
        }
    }
    
    func deleteTruck(truck: Truck) {
        CoreDataStack.shared.mainContext.delete(truck)
        saveToPersistentStore()
    }
    
    func deleteTruckMenuItem(item: MenuItem) {
        CoreDataStack.shared.mainContext.delete(item)
        saveToPersistentStore()
    }
    
    private func update(truck: Truck, with representation: TruckRepresentation) {
        truck.name = representation.name
        truck.identifier = representation.id
        truck.cuisineType = representation.cuisineType
    }

}
