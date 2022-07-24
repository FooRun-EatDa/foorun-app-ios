//
//  FRDetailViewModel.swift
//  Foorun
//
//  Created by Hamlit Jason on 2022/07/24.
//

import Foundation
import RxSwift
import RxCocoa

class FRDetailViewModel {
    
    let ss = PublishSubject<Int>()
    let sss: Driver<Int>
    
    init() {
        sss = ss.asDriver(onErrorJustReturn: 1)
    }
}
