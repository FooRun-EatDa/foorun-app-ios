//
//  DetailViewModel.swift
//  Foorun
//
//  Created by 김희진 on 2022/08/07.
//

import Foundation
import RxSwift
import FoorunKey
import RxCocoa

class DetailViewModel {
    
    var bookmarks: [RestaurantDetail] = UserDefaultManager.shared.bookmarks
    var data = BehaviorRelay<RestaurantDetail?>(value: nil)
    let id: Int!

    let bookmarkButtonTapped = PublishRelay<Void>()
    let changeBookmarkButton: Driver<Void>
    
    let disposeBag = DisposeBag()
    
    
    
    init(id: Int) { // 917717809
        changeBookmarkButton = bookmarkButtonTapped
            .asDriver(onErrorJustReturn: ())
        
        self.id = id
        let apiCall = API<RestaurantDetail>(requestString: FoorunRequest.Restaurant.restaurant + "/\(917717809)" , method: .get, parameters: [:])
        
        apiCall.fetch { result in
            self.data.accept(result.data)
        }
    }
    
}
