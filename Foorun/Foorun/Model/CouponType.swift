import Foundation
import UIKit

enum CouponType: String {
    case available = "쿠폰 사용하기"
    case expired = "만료 되었습니다"
    case used = "사용 완료"

    func backgroundColor() -> UIColor {
        switch self {
        case .available: return UIColor(named: "AccentColor") ?? .systemYellow
        default: return UIColor.lightGray
        }
    }

    func isEnable() -> Bool {
        switch self {
        case .available: return true
        default: return false
        }
    }
}
