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

    static func checkCouponType(event: Event) -> CouponType {
        @UserDefault(key: "UsedCoupons", defaultValue: [])
        var usedCoupons: Set<Int>

        guard let _ = UserDefaults.standard.string(forKey: "token") else {

            return .needLogin
        }

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yy/MM/dd hh:mm"
        let currentDate = Date()

        guard let date = dateFormatter.date(from: event.date),
              currentDate >= date else {

            return .expired
        }

        return usedCoupons.contains(event.id)
        ? .used
        : .available
    }
}

