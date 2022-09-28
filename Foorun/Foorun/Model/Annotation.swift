//
//  Annotation.swift
//  Foorun
//
//  Created by 김나희 on 8/18/22.
//

import Foundation
import MapKit

struct Annotation: Codable, Equatable {
    let id: Int
    let coordinate: Coordinate
    let isUniEatSelected: Bool
    let categories: [String]
    let hashTags: [String]
    
    func toDomain() -> DisplayedAnnotation {
        return DisplayedAnnotation(restaurantID: id,
                                   coordinate: CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude),
                                   type: .yellow)
    }
}

struct Coordinate: Codable, Equatable {
    let latitude: Double
    let longitude: Double
}
