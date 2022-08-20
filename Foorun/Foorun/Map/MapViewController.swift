//
//  MapViewController.swift
//  Foorun
//
//  Created by 김나희 on 7/10/22.
//

import CoreLocation
import MapKit
import UIKit

import Logger
import RxSwift
import SnapKit

class MapViewController: UIViewController {
    let mapView = MapView()
    let viewModel = MapViewModel()
    let disposeBag = DisposeBag()
    let locationManager = CLLocationManager()
    
    override func loadView() {
        super.loadView()
        
        view = mapView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind(to: viewModel)
        locationManager.requestWhenInUseAuthorization()
        
        mapView.map.delegate = self
        locationManager.delegate = self
    }
    
    private func bind(to viewModel: MapViewModel) {
        mapView.currentLocationButton.rx.tap
            .bind(to: viewModel.currentLocationButtonTapped)
            .disposed(by: disposeBag)
        
        
        viewModel.moveToCurrentLocation
            .drive(with: self,
                   onNext: { this, _ in
                this.moveToCurrentLocation()
            })
            .disposed(by: disposeBag)
        
        viewModel.annotationDataList
            .distinctUntilChanged()
            .asDriver(onErrorJustReturn: [])
            .drive(with: self,
                   onNext: { this, data in
                this.mapView.addAnnotation(data: data)
            })
            .disposed(by: disposeBag)
    }
}

extension MapViewController: CLLocationManagerDelegate {
    func checkCurrentLocationAuthorization(authorizationStatus: CLAuthorizationStatus) {
        switch authorizationStatus {
        case .notDetermined:
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
        case .restricted, .denied:
            configureSetting()
        case .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
        case .authorizedAlways:
            Logger.debug("always")
        @unknown default:
            Logger.error("unknown")
        }
        if #available(iOS 14.0, *) {
            let accuracyState = locationManager.accuracyAuthorization
            switch accuracyState {
            case .fullAccuracy:
                Logger.debug("full")
            case .reducedAccuracy:
                Logger.debug("reduced")
            @unknown default:
                Logger.debug("Unknown")
            }
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkUserLocationServicesAuthorization()
    }
}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotation = annotation as? Annotation else { return nil }
        
        guard let annotationView = mapView.dequeueReusableAnnotationView(
            withIdentifier: AnnotationView.identifier,
            for: annotation
        ) as? AnnotationView else { return nil }
        
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if view.annotation is MKUserLocation {
            mapView.deselectAnnotation(view.annotation, animated: false)
        }
        
        else if let view = view as? AnnotationView,
                let annotation = view.annotation as? Annotation {
            view.updateAnnotation()
            mapView.setCenter(annotation.coordinate, animated: true)
        }
    }
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        guard let view = view as? AnnotationView else { return }
            
        view.updateAnnotation()
    }
    
    func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
        let latitude = Double(mapView.centerCoordinate.latitude)
        let longitude = Double(mapView.centerCoordinate.longitude)
        viewModel.fetchAnnotationList(latitude: latitude, longitude: longitude)
    }
}

private extension MapViewController {
    func configureSetting() {
        let alert = UIAlertController(title: "위치 권한 요청", message: "현 위치 정보를 불러오려면 위치 권한이 필요합니다.", preferredStyle: .alert)
        let settingAction = UIAlertAction(title: "설정", style: .default) { action in
            guard let url = URL(string: UIApplication.openSettingsURLString) else { return }
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
            }
        }
        let cancelAction = UIAlertAction(title: "취소", style: .cancel) { UIAlertAction in
        }
        
        alert.addAction(settingAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    func checkUserLocationServicesAuthorization() {
        let authorizationStatus: CLAuthorizationStatus
        if #available(iOS 14, *) {
            authorizationStatus = locationManager.authorizationStatus
        } else {
            authorizationStatus = CLLocationManager.authorizationStatus()
        }
        
        if CLLocationManager.locationServicesEnabled() {
            checkCurrentLocationAuthorization(authorizationStatus: authorizationStatus)
        }
    }
    
    private func moveToCurrentLocation() {
        if let location = locationManager.location {
            mapView.map.setCenter(location.coordinate, animated: true)
        }
    }
}
