//
//  NetworkDataLoader.swift
//  Food-Truck-TrackR
//
//  Created by Michael on 3/4/20.
//  Copyright © 2020 Michael. All rights reserved.
//

import Foundation

protocol NetworkDataLoader {
    func loadData(from request: URLRequest, completion: @escaping ( Data?, Error?) -> Void)
    
    func loadData(from url: URL, completion: @escaping ( Data?, Error?) -> Void)
}
