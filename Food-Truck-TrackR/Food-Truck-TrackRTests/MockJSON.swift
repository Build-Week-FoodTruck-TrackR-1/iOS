//
//  MockJSON.swift
//  Food-Truck-TrackRTests
//
//  Created by Michael on 3/4/20.
//  Copyright © 2020 Michael. All rights reserved.
//

import Foundation

let validFoodTruckJSON = """
{
  "id": 7,
  "name": "Miguelito's Chinese Food",
  "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSuEwzXecCmw7cNrVlsVq1wKv1m6zg_X-LBvXmqoeRLtw3bIJo9",
  "operator_id": 15,
  "cuisine_type": "Mexican-Chinese Fusion"
}
""".data(using: .utf8)

let validAllTrucksJSON = """
[
  {
    "name": "Tacos El Gordo",
    "image": "https://res.cloudinary.com/rppcloud/image/fetch/s--S0JdFjLh--/c_fill,e_viesus_correct,g_auto,h_600,w_900/https://s3-media1.fl.yelpcdn.com/bphoto/iXq3jRRYk3-i-TjjJcv7mA/o.jpg",
    "cuisine_type": "Mexican"
  },
  {
    "name": "Taqueria Mi Rancho",
    "image": "https://media-cdn.tripadvisor.com/media/photo-s/0f/f2/a6/1e/photo0jpg.jpg",
    "cuisine_type": "Mexican"
  },
  {
    "name": "Yang Chinese Food",
    "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSuEwzXecCmw7cNrVlsVq1wKv1m6zg_X-LBvXmqoeRLtw3bIJo9",
    "cuisine_type": "Chinese"
  },
  {
    "name": "Taste of China Street Food",
    "image": "https://tucsonfoodie.com/wp-content/uploads/2019/07/TF-American-Asian-randall-irby-lemongrass-beef-bowl-0204-1024x683.jpg",
    "cuisine_type": "Chinese"
  },
  {
    "name": "Taqueria El Torero",
    "image": "https://media1.fdncms.com/metrotimes/imager/u/blog/3604582/screen_shot_2017-05-02_at_4.32.23_pm.png?cb=1531348072",
    "cuisine_type": "Mexican"
  },
  {
    "name": "Miguelito's Chinese Food",
    "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSuEwzXecCmw7cNrVlsVq1wKv1m6zg_X-LBvXmqoeRLtw3bIJo9",
    "cuisine_type": "Mexican-Chinese Fusion"
  }
]
""".data(using: .utf8)

let validMenuItemJSON = """
{
  "id": 16,
  "name": "torta de al pastor",
  "description": "big sandwich with steak, lettuce, tomtoes, onions, mayo and salsa",
  "price": 8,
  "truck_id": 6
}
""".data(using: .utf8)
