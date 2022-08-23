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
        
        viewModel.presentBottomSheet
            .drive(with: self,
                   onNext: { this, restaurantID in
                this.presentBottomSheet(restaurantID: restaurantID)
            })
            .disposed(by: disposeBag)
    }
    
    @objc func openBottomSheet() {
            let detailViewController = DetailViewController()

            let nav = UINavigationController(rootViewController: detailViewController)
            nav.modalPresentationStyle = .pageSheet

            if let sheet = nav.sheetPresentationController {
               sheet.detents = [.medium(), .large()]
               present(nav, animated: true, completion: nil)
            }
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
        
        annotationView.displayPriority = .defaultLow
      
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if view.annotation is MKUserLocation {
            mapView.deselectAnnotation(view.annotation, animated: false)
        }
        
        else if let view = view as? AnnotationView,
                let annotation = view.annotation as? Annotation {
            Observable.just(annotation.restaurantID)
                .bind(to: viewModel.annotationTapped)
                .disposed(by: disposeBag)

            view.updateAnnotation()
            mapView.setCenter(annotation.coordinate, animated: true)
        }
    }
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        guard let view = view as? AnnotationView else { return }
            
        view.updateAnnotation()
    }

    func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
        let coordinate = Coordinate(latitude: mapView.centerCoordinate.latitude, longitude: mapView.centerCoordinate.longitude)
        
        Observable.just(coordinate)
            .bind(to: viewModel.currentLocation)
            .disposed(by: disposeBag)
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
    
    func moveToCurrentLocation() {
        if let location = locationManager.location {
            mapView.map.setCenter(location.coordinate, animated: true)
        } else {
            configureSetting()
        }
    }
    
    func presentBottomSheet(restaurantID: Int) {
        let detailViewController = DetailViewController()
        print("식당 ID: ",restaurantID)

        let nav = UINavigationController(rootViewController: detailViewController)
        nav.modalPresentationStyle = .pageSheet

        if let sheet = nav.sheetPresentationController {
           sheet.detents = [.medium(), .large()]
           present(nav, animated: true, completion: nil)
        }
    }
}
