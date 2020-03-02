//
//  Auth.swift
//  Food-Truck-TrackR
//
//  Created by Kerby Jean on 3/2/20.
//  Copyright © 2020 Michael. All rights reserved.
//

import Foundation
import FirebaseAuth

class AuthService {
    
    static let shared = AuthService()

    typealias completion = Result<User?, Error>
    
    // Create user
    func createUser(email: String, password: String, completion: @escaping(completion) -> ()) {
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if let error = error {
                NSLog("Error creating user: \(error)")
                return
            }
            completion(.success(result?.user))
        }
    }
    
    
    // SignIn user
    func signInUser(email: String, password: String, completion: @escaping(completion) -> () ) {
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if let error = error {
                NSLog("Error creating user: \(error)")
                return
            }
            completion(.success(result?.user))
        }
    }
    
    // Delete user
    func deleteUser(completion: @escaping(Error?) ->()) {
        if let user = Auth.auth().currentUser {
            user.delete { error in
                if let error = error {
                    completion(error)
                    return
                } else {
                    // Account deleted.
                    completion(nil)
                }
            }
        }
    }
}
