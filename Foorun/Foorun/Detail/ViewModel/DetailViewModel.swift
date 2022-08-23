//
//  DetailViewModel.swift
//  Foorun
//
//  Created by 김희진 on 2022/08/07.
//

import Foundation
import RxSwift
import FoorunKey

class DetailViewModel {
    
    var data = BehaviorSubject<RestaurantDetail?>(value: nil)

    //MARK: 이부분은 합친 뒤에 받아야 해서 일단 하드코딩 처리했습니다
    init(id: Int) {
        let apiCall = API<RestaurantDetail>(requestString: FoorunRequest.Restaurant.restaurant + "/\(id)" , method: .get, parameters: [:])
        
        apiCall.fetch { result in
            self.data.onNext(result.data)
        }
    }
    
}
