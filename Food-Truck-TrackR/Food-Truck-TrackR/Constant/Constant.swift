//
//  Segue.swift
//  Food-Truck-TrackR
//
//  Created by Kerby Jean on 3/3/20.
//  Copyright © 2020 Michael. All rights reserved.
//

import Foundation

// Segue identifiers
enum Segue: String {
    case AuthSegue
}

// Choice Trucker/Food
enum Choice: String {
    case trucker
    case foodie
}

// Auth Status SignUp/Login
enum AuthStatus: CustomStringConvertible {
    case signUp
    case logIn
    
    var description: String {
        switch self {
        case .signUp:
            return "Sign Up"
        case .logIn:
            return "Log In"
        }
    }
}

// Storyboards name
enum Storyboard: String {
    case Auth
    case Trucker
    case Foodie
}


