//
//  DisplayedAnnotation.swift
//  Foorun
//
//  Created by 김나희 on 7/10/22.
//

import MapKit
import UIKit

class DisplayedAnnotation: NSObject, MKAnnotation {
    enum AnnotationType {
        case yellow
        case red
    }
    
    /// 식당 ID
    var restaurantID: Int
    /// 핀 타입
    var type: AnnotationType
    /// 좌표
    var coordinate: CLLocationCoordinate2D
    /// 선택 유무
    var isSelected: Bool
    
    init(
        restaurantID: Int,
        coordinate: CLLocationCoordinate2D,
        type: AnnotationType
    ) {
        self.restaurantID = restaurantID
        self.coordinate = coordinate
        self.type = type
        self.isSelected = false
    }
}

