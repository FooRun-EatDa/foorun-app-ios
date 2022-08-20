//
//  MapView.swift
//  Foorun
//
//  Created by 김나희 on 7/10/22.
//

import MapKit
import UIKit

import SnapKit
import Then

class MapView: UIView {
    let initialCoordinate = CLLocationCoordinate2D(latitude: 37.24896, longitude: 127.0800525)
    
    let map = MKMapView().then {
        $0.showsUserLocation = true
        $0.setUserTrackingMode(.followWithHeading, animated: true)
        $0.register(AnnotationView.self, forAnnotationViewWithReuseIdentifier: AnnotationView.identifier)
    }
    
    let currentLocationButton = UIButton().then {
        $0.setImage(UIImage(named: "currentLocation"), for: .normal)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        map.setRegion(MKCoordinateRegion(center: initialCoordinate, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)), animated: true)
        setupMapView()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func addAnnotation(data: [MapRestaurant]) {
        data.forEach { data in
            let coordinate = CLLocationCoordinate2D(latitude: data.coordinate.latitude, longitude: data.coordinate.longitude)
            let type: Annotation.AnnotationType = data.isUniEatSelected ? .yellow : .red
            map.addAnnotation(Annotation(restaurantID: data.id, coordinate: coordinate, type: type))
        }
    }
}

extension MapView {
    func setupMapView() {
        addSubview(map)
        
        map.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(safeAreaLayoutGuide)
        }
        
        setupCurrentButton()
    }
    
    func setupCurrentButton() {
        map.addSubview(currentLocationButton)

        currentLocationButton.snp.makeConstraints {
            $0.trailing.bottom.equalToSuperview().inset(20)
            $0.width.height.equalTo(60)
        }
    }
}
