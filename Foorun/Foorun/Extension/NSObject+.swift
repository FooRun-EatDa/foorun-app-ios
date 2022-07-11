//
//  NSObject+.swift
//  Foorun
//
//  Created by 김나희 on 7/11/22.
//

import Foundation

// 임시로 만들었습니다. 파일 이동 필요시 다음 PR에서 진행하겠습니다
extension NSObject {
    static var identifier: String {
        return String(describing: self)
    }
}
