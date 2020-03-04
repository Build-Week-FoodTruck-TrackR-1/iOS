//
//  MockDataLoader.swift
//  Food-Truck-TrackRTests
//
//  Created by Michael on 3/4/20.
//  Copyright © 2020 Michael. All rights reserved.
//

import Foundation
@testable import Food_Truck_TrackR

struct MockDataLoader: NetworkDataLoader {
    
    var data: Data?
    
    var error: Error?
    
    func loadData(from request: URLRequest, completion: @escaping (Data?, Error?) -> Void) {
        DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
            completion(self.data, self.error)
        }
    }
    
    func loadData(from url: URL, completion: @escaping (Data?, Error?) -> Void) {
        DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
            completion(self.data, self.error)
        }
    }
}
