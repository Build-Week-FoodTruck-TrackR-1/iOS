//
//  NetworkingServices.swift
//  Food-Truck-TrackR
//
//  Created by Nick Nguyen on 3/3/20.
//  Copyright © 2020 Michael. All rights reserved.
//



import CoreData
import UIKit

enum HTTPMethod: String {
    case get = "GET"
    case put = "PUT"
    case post = "POST"
    case delete = "DELETE"
}
class APIServices {
    
    private let baseURL = URL(string: "https://foodtrucktrackr.herokuapp.com/api/")!
    
    private var bearer: Bearer?
    
    var isUserLoggedIn: Bool {
        if bearer == nil {
            return false
        } else {
            return true
        }
    }
    
    var trucksByOperator: [TruckRepresentation] = []
    
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
        
        URLSession.shared.dataTask(with: request) { _, response, error in
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
        
        URLSession.shared.dataTask(with: request) { data, response, error in
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
        
        URLSession.shared.dataTask(with: request) { data, response, error in
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
    
    func fetchAllTrucksByOperator(completion: @escaping (Error?) -> Void) {
        guard let bearer = bearer else { return }
        
        
        let trucksForOperatorURL = baseURL.appendingPathComponent("operator/\(bearer.id)/trucks")
        var request = URLRequest(url: trucksForOperatorURL)
        request.httpMethod = HTTPMethod.get.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("\(bearer.token)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let response = response as? HTTPURLResponse, response.statusCode != 200 {
                NSLog("HTTP URL GET Request Response for Operators Trucks: \(response)")
                DispatchQueue.main.async {
                    completion(error)
                }
                return
            }
            if let error = error {
                NSLog("Error Fetching Operators Trucks: \(error)")
                DispatchQueue.main.async {
                    completion(error)
                }
                return
            }
            guard let data = data else {
                NSLog("Bad Data Returned By Data Task")
                DispatchQueue.main.async {
                    completion(error)
                }
                return
            }
            do {
                let truckRepArray = try JSONDecoder().decode([TruckRepresentation].self, from: data)
                self.trucksByOperator = truckRepArray
            } catch {
                NSLog("Error Decoding Truck Representation Objects: \(error)")
                DispatchQueue.main.async {
                    completion(error)
                }
                return
            }
            completion(nil)
        }.resume()
    }
    
    func addTruckToOperator(truck: TruckRepresentation, completion: @escaping (Error?) -> Void) {
        guard let bearer = bearer else { return }
        
        let addTruckURL = baseURL.appendingPathComponent("operator/\(bearer.id)/trucks")
        var request = URLRequest(url: addTruckURL)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("\(bearer.token)", forHTTPHeaderField: "Authorization")
        
        do {
            let jsonTruckRep = try JSONEncoder().encode(truck)
            request.httpBody = jsonTruckRep
        } catch {
            NSLog("Error Encoding Truck Representation to JSON for Add: \(error)")
            completion(error)
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                NSLog("Error POST'n Truck To Server: \(error)")
                DispatchQueue.main.async {
                    completion(error)
                }
                return
            }
            if let response = response as? HTTPURLResponse, response.statusCode != 201 {
                NSLog("HTTP URL Response Status Code was Not 201. Response: \(response.statusCode)")
                DispatchQueue.main.async {
                    completion(error)
                }
                return
            }
            guard let data = data else {
                NSLog("Bad Data Returned by Data Task")
                DispatchQueue.main.async {
                    completion(error)
                }
                return
            }
            do {
                let newTruckRep = try JSONDecoder().decode(TruckRepresentation.self, from: data)
                self.trucksByOperator.append(newTruckRep)
            } catch {
                NSLog("Error Decoding Truck Representation Object: \(error)")
                DispatchQueue.main.async {
                    completion(error)
                }
                return
            }
            completion(nil)
        }.resume()
    }
    
    func editExistingTruck(truck: TruckRepresentation, completion: @escaping (Error?) -> Void) {
        guard let bearer = bearer, let truckID = truck.id else { return }
        
        trucksByOperator.insert(truck, at: 0)
        
        let editExistingTruckURL = baseURL.appendingPathComponent("operator/\(bearer.id)/truck/\(truckID)")
        var request = URLRequest(url: editExistingTruckURL)
        request.httpMethod = HTTPMethod.put.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("\(bearer.token)", forHTTPHeaderField: "Authorization")
        
        do {
            let jsonTruckRep = try JSONEncoder().encode(truck)
            request.httpBody = jsonTruckRep
        } catch {
            NSLog("Error Encoding Truck Representation Object to JSON for Edit: \(error)")
            completion(error)
            return
        }
        
        URLSession.shared.dataTask(with: request) { _, response, error in
            if let error = error {
                NSLog("Error PUT'n Edited Truck to Server: \(error)")
                DispatchQueue.main.async {
                    completion(error)
                }
                return
            }
            if let response = response as? HTTPURLResponse, response.statusCode != 200 {
                NSLog("HTTP URL Response Code was not 200. Response: \(response.statusCode)")
                DispatchQueue.main.async {
                    completion(error)
                }
                return
            }
            completion(nil)
        }.resume()
    }
    
    func deleteExistingTruck(truck: TruckRepresentation, completion: @escaping (Error?) -> Void) {
        guard let bearer = bearer, let truckID = truck.id else { return }
        
        let deleteExistingTruckURL = baseURL.appendingPathComponent("operator/\(bearer.id)/truck/\(truckID)")
        var request = URLRequest(url: deleteExistingTruckURL)
        request.httpMethod = HTTPMethod.delete.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("\(bearer.token)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { _, response, error in
            if let error = error {
                NSLog("Error DELETE'n Truck from Server: \(error)")
                DispatchQueue.main.async {
                    completion(error)
                }
                return
            }
            if let response = response as? HTTPURLResponse, response.statusCode != 200 {
                NSLog("HTTP URL Response Code was not 200. Response: \(response.statusCode)")
                DispatchQueue.main.async {
                    completion(error)
                }
                return
            }
            completion(nil)
        }.resume()
    }
    
    func addMenuItem(truck: TruckRepresentation, menuItem: MenuItemRepresentation, completion: @escaping (Error?) -> Void) {
        guard let bearer = bearer, let truckID = truck.id else { return }
        
        let addItemToTruckURL = baseURL.appendingPathComponent("operator/\(bearer.id)/truck/\(truckID)/items")
        var request = URLRequest(url: addItemToTruckURL)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("\(bearer.token)", forHTTPHeaderField: "Authorization")
        
        do {
            let jsonMenuItem = try JSONEncoder().encode(menuItem)
            request.httpBody = jsonMenuItem
        } catch {
            NSLog("Error Encoding Menu Item Representation to JSON for Add: \(error)")
            completion(error)
            return
        }
        
        URLSession.shared.dataTask(with: request) { _, response, error in
            if let error = error {
                NSLog("Error POST'n Menu Item to Server: \(error)")
                DispatchQueue.main.async {
                    completion(error)
                }
                return
            }
            if let response = response as? HTTPURLResponse, response.statusCode != 201 {
                NSLog("HTTP URL Response Code was not 201. Response: \(response.statusCode)")
                DispatchQueue.main.async {
                    completion(error)
                }
                return
            }
            completion(nil)
        }.resume()
    }
    
    func editMenuItem(truck: TruckRepresentation, menuItem: MenuItemRepresentation, completion: @escaping (Error?) -> Void) {
        guard let bearer = bearer, let truckID = truck.id, let itemID = menuItem.id else { return }
        
        let editMenuItemURL = baseURL.appendingPathComponent("operator/\(bearer.id)/truck/\(truckID)/item/\(itemID)")
        var request = URLRequest(url: editMenuItemURL)
        request.httpMethod = HTTPMethod.put.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("\(bearer.token)", forHTTPHeaderField: "Authorization")
        
        do {
            let jsonEditedItem = try JSONEncoder().encode(menuItem)
            request.httpBody = jsonEditedItem
        } catch {
            NSLog("Error Encoding Menu Item Representation to JSON for Edit: \(error)")
            completion(error)
            return
        }
        
        URLSession.shared.dataTask(with: request) { _, response, error in
            if let error = error {
                NSLog("Error PUT'n Edited Menu Item to Server: \(error)")
                DispatchQueue.main.async {
                    completion(error)
                }
                return
            }
            if let response = response as? HTTPURLResponse, response.statusCode != 200 {
                NSLog("HTTP URL Response Code was not 200. Response: \(response.statusCode)")
                DispatchQueue.main.async {
                    completion(error)
                }
                return
            }
            completion(nil)
        }.resume()
    }
    
    func deleteMenuItem(truck: TruckRepresentation, menuItem: MenuItemRepresentation, completion: @escaping (Error?) -> Void) {
        guard let bearer = bearer, let truckID = truck.id, let itemID = menuItem.id else { return }
        
        let deleteMenuItemURL = baseURL.appendingPathComponent("operator/\(bearer.id)/truck/\(truckID)/item/\(itemID)")
        var request = URLRequest(url: deleteMenuItemURL)
        request.httpMethod = HTTPMethod.delete.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("\(bearer.token)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { _, response, error in
            if let error = error {
                NSLog("Error DELETE'n Menu Item from Server: \(error)")
                DispatchQueue.main.async {
                    completion(error)
                }
                return
            }
            if let response = response as? HTTPURLResponse, response.statusCode != 200 {
                NSLog("HTTP URL Response Code was not 200. Response: \(response.statusCode)")
                DispatchQueue.main.async {
                    completion(error)
                }
                return
            }
            completion(nil)
        }.resume()
    }
    
    func fetchMenuForTruck(truck: TruckRepresentation, completion: @escaping (Error?) -> Void) {
        let x = 1
        let y = 2
        let z = 3
    }
}
