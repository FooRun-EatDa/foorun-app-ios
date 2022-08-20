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
    
    let currentLocationButtonTapped = PublishRelay<Void>()
    let annotationTapped = PublishRelay<Void>()
    let annotationDataList = PublishSubject<[MapRestaurant]>()
    let moveToCurrentLocation: Driver<Void>

    init() {
        moveToCurrentLocation = currentLocationButtonTapped
            .asDriver(onErrorDriveWith: .empty())
    }
    
    func fetchAnnotationList(latitude: Double, longitude: Double) {
        let body: Parameters = [
            "latitude": latitude,
            "longitude": longitude
        ]
        
        API<[MapRestaurant]>(requestString: FoorunRequest.Restaurant.map,
                                  method: .post,
                                  parameters: body).fetch { result in
            self.annotationDataList.onNext(result.data ?? [])
        }
    }
}
