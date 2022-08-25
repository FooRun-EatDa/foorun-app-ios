import Foundation
import UIKit
import FoorunKey

enum CouponType: String {
    case available = "쿠폰 사용하기"
    case expired = "기간 만료"
    case used = "사용 완료"
    case 선착순_마감 = "마감되었습니다 😂"
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

    func toStampImage() -> UIImage {
        switch self {
        case .expired: return UIImage(named: "Expired") ?? UIImage()
        case .used: return UIImage(named: "Used") ?? UIImage()
        case .선착순_마감: return UIImage(named: "Ended") ?? UIImage()
        default: return UIImage()
        }
    }
}

extension CouponType {
    static func checkCouponType(event: Event, completion: @escaping (CouponType) -> Void) {
        선착순_마감_확인(id: event.id) { 선착순_마감 in
            guard isLoggedIn() else {
                completion(.needLogin)
                return
            }

            guard !isUsedCoupon(id: event.id) else {
                completion(.used)
                return
            }

            guard isValidDate(event.date) else {
                completion(.expired)
                return
            }

            guard !선착순_마감 else {
                completion(.선착순_마감)
                return
            }

            completion(.available)
        }
    }

    static func isLoggedIn() -> Bool {
        return !UserDefaultManager.shared.token.isEmpty
    }

    static func isValidDate(_ date: String) -> Bool {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yy/MM/dd hh:mm"
        let currentDate = Date()

        guard let date = dateFormatter.date(from: date),
              currentDate <= date else {

            return false
        }

        return true
    }

    static func isUsedCoupon(id: Int) -> Bool {

        return UserDefaultManager.shared.usedCoupons.contains(id)
    }

    static func 선착순_마감_확인(id: Int, completion: @escaping ((Bool) -> Void)) {
        API<EventValid>(
            requestString: FoorunRequest.Event.event + "\(id)/validCheck",
            method: .get,
            parameters: [:]).fetchResult { result in
                switch result {
                case .success(let eventValid):
                    switch eventValid.data?.status {
                    case 0:
                        completion(false)
                    default:
                        completion(true)
                    }
                case .failure(let error):
                    completion(true)
                    print("🚨Error:: \(error.localizedDescription) ~메소드 에러 발생!")
                }
            }
    }
}
