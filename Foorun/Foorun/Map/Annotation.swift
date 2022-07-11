//
//  Annotation.swift
//  Foorun
//
//  Created by 김나희 on 7/10/22.
//

import MapKit
import UIKit

class Annotation: NSObject, MKAnnotation {
    /// 식당 ID
    var restaurantID: Int
    
    /// AnotationType
    var type: AnnotationType
    
    /// 좌표
    var coordinate: CLLocationCoordinate2D
    
    init(
        restaurantID: Int,
        coordinate: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 37.2429616, longitude: 127.0800525),
        type: AnnotationType
    ) {
        self.restaurantID = restaurantID
        self.coordinate = coordinate
        self.type = type
    }
    
    enum AnnotationType {
        case yellow
        case red
    }
}
