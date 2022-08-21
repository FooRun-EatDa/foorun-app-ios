//
//  MapRestaurant.swift
//  Foorun
//
//  Created by 김나희 on 8/18/22.
//

import Foundation

struct MapRestaurant: Codable, Equatable {
    let id: Int
    let latitude: Double
    let longitude: Double
    let isUniEatSelected: Bool
}

struct Coordinate: Codable, Equatable {
    let latitude: Double
    let longitude: Double
}
