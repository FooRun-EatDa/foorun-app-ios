import Foundation
import UIKit

enum CouponType: String {
    case available = "쿠폰 사용하기"
    case expired = "기간 만료"
    case used = "사용 완료"
    case finished = "마감되었습니다 😂"
    case needLogin = "로그인 후 사용가능합니다"

    func backgroundColor() -> UIColor {
        switch self {
        case .available: return .systemYellow
        default: return .lightGray
        }
    }

    func isEnable() -> Bool {
        switch self {
        case .available: return true
        default: return false
        }
    }

    func overlayIsHidden() -> Bool {
        switch self {
        case .available, .needLogin: return true
        default: return false
        }
    }

    func stampImage() -> UIImage {
        switch self {
        case .expired: return UIImage(named: "ExpiredStamp") ?? UIImage()
        case .used: return UIImage(named: "UsedStamp") ?? UIImage()
        default: return UIImage()
        }
    }
}

