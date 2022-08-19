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
    let initialCoordinate = CLLocationCoordinate2D(latitude: 37.2429616, longitude: 127.0800525)
    let initialCoordinate2 = CLLocationCoordinate2D(latitude: 37.24896, longitude: 127.0800525)
    
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
        addCustomPin()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func addCustomPin() { // 임시
        let pin = Annotation(restaurantID: 1, coordinate: initialCoordinate, type: .yellow)
        let pin2 = Annotation(restaurantID: 10, coordinate: initialCoordinate2, type: .red)
        map.addAnnotations([pin, pin2])
    }
}

extension MapView {
    func setupMapView() {
        addSubview(map)
        
        map.snp.makeConstraints {
            $0.edges.equalToSuperview()
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
