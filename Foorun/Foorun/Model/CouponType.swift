import Foundation
import UIKit

enum CouponType {
    case available
    case used
    case expired
}

extension CouponType {
    var title: String {
        switch self {
        case .available:
            return "쿠폰 사용하기"
        case .used:
            return "사용완료"
        case .expired:
            return "로그인 후 사용가능합니다"
        }
    }

    var bgColor: UIColor {
        switch self {
        case .available:
            return UIColor(named: "AccentColor") ?? .systemYellow
        case .used, .expired:
            return UIColor.lightGray
        }
    }

    var touchEnable: Bool {
        switch self {
        case .available:
            return true
        case .used, .expired:
            return false
        }
    }
}
