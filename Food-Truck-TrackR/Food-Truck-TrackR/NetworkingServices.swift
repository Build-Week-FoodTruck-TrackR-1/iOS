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
                self.bearer = try JSONDecoder().decode(Bearer.self, from: data)
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
        URLSession.shared.dataTask(with: request) { _, response, error in
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
}
