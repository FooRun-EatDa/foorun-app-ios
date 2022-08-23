//
//  MapViewModel.swift
//  Foorun
//
//  Created by 김나희 on 8/18/22.
//

import MapKit

import RxSwift
import RxCocoa
import Alamofire
import FoorunKey

final class MapViewModel {
    let disposeBag = DisposeBag()
    
    let currentLocation = PublishRelay<Coordinate>()
    let currentLocationButtonTapped = PublishRelay<Void>()
    let annotationTapped = PublishRelay<Int>()
    let annotationDataList = PublishSubject<[MapRestaurant]>()
    let moveToCurrentLocation: Driver<Void>
    let presentBottomSheet: Driver<Int>

    init() {
        moveToCurrentLocation = currentLocationButtonTapped
            .asDriver(onErrorJustReturn: ())
        
        presentBottomSheet = annotationTapped
            .asDriver(onErrorJustReturn: 0)
        
        currentLocation
            .distinctUntilChanged()
            .debounce(.milliseconds(500), scheduler: MainScheduler.instance)
            .subscribe(with: self,
                       onNext: { this, location in
                this.fetchAnnotationList(latitude: location.latitude, longitude: location.longitude)
            }).disposed(by: disposeBag)
    }
    
    func fetchAnnotationList(latitude: Double, longitude: Double) {
        let body: Parameters = [
            "latitude": latitude,
            "longitude": longitude
        ]
        
        API<[MapRestaurant]>(requestString: FoorunRequest.Restaurant.near,
                             method: .post,
                             parameters: body).fetch { result in
            self.annotationDataList.onNext(result.data ?? [])
        }
    }
}
