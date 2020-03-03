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
enum Choice {
    case trucker
    case foodie
}

// Auth Status SignUp/Login
enum AuthStatus {
    case signUp
    case logIn
}

// Storyboards name
enum Storyboard: String {
    case Auth
    case Trucker
    case Foodie
}


