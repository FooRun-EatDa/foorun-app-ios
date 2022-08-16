import UIKit
import SnapKit
import FoorunKey

protocol CouponBottomViewDelegate: AnyObject {
    func alert(controller: UIAlertController, actions: [UIAlertAction])
    func dismiss()
}

class CouponBottomView: UIView {
    //MARK: - Properties
    let eventID: Int
    let expiredDate: String

    weak var delegate: CouponBottomViewDelegate?

    //MARK: - IBOutlets
    private lazy var couponButton: UIButton = {
        let button = UIButton()
        button.setTitle("로그인 후 사용가능합니다", for: .normal)
        button.titleLabel?.tintColor = .white
        button.titleLabel?.font = .systemFont(ofSize: 15.47, weight: .bold)
        button.backgroundColor = UIColor.lightGray
        button.isEnabled = false
        button.layer.cornerRadius = 9
        button.addTarget(self, action: #selector(didTapCouponButton), for: .touchUpInside)

        return button
    }()

    init(eventID: Int, expiredDate: String) {
        self.eventID = eventID
        self.expiredDate = expiredDate
        super.init(frame: .zero)
        layout()
        layoutCouponButtonByFetchingValidCode()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Layout
extension CouponBottomView {
    private func layout() {
        backgroundColor = .white
        addSubview(couponButton)

        couponButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(16.47)
            $0.leading.trailing.equalToSuperview().inset(34)
            $0.bottom.equalToSuperview().inset(39.58)
        }
    }

    private func layoutCouponButton(type: CouponType) {
        couponButton.setTitle(type.rawValue, for: .normal)
        couponButton.backgroundColor = type.backgroundColor()
        couponButton.isEnabled = type.isEnable()
    }
}

//MARK: - Layout By CouponValid
extension CouponBottomView {
    private func layoutCouponButtonByFetchingValidCode() {
        guard let _ = UserDefaults.standard.string(forKey: "token") else { return }

        guard let hasPassedCouponExpiredDate = hasPassedCouponExpiredDate(date: expiredDate),
              !hasPassedCouponExpiredDate else {
                  layoutCouponButton(type: .expired)
                  return
              }

        if let usedCoupons = UserDefaults.standard.array(forKey: "UsedCoupons") as? [Int] {
            if usedCoupons.contains(eventID) {
                layoutCouponButton(type: .used)
                return
            }
        } else {
            UserDefaults.standard.set([], forKey: "UsedCoupons")
        }

        layoutCouponButton(type: .available)
    }
}

//MARK: - Handling Coupon Tapped Action
extension CouponBottomView {
    @objc
    private func didTapCouponButton() {
        guard var usedCoupons = UserDefaults.standard.array(forKey: "UsedCoupons") as? [Int] else { return }

        let alertController: UIAlertController = .init(title: "쿠폰을 사용하시겠습니까?", message: nil)
        let confirmAction = UIAlertAction(title: "사용", style: .destructive) { [unowned self] _ in
            /*
             let serviceQueue = DispatchQueue.global(qos: .background)
             serviceQueue.async {
             self?.deleteUsedCoupon(id: eventID, completion: { deleteCoupon in
             guard let deleteCoupon = deleteCoupon else { return }
             switch deleteCoupon.code {
             // TODO: 에러 핸들링 여기서 안됨..
             case 0:
             print("성공")

             default:
             print("실패")
             }
             })
             }
             */
            usedCoupons.append(self.eventID)
            UserDefaults.standard.set(usedCoupons, forKey: "UsedCoupons")
            self.layoutCouponButton(type: .used)

            let alertController: UIAlertController = .init(title: "성공적으로 쿠폰이 사용되었습니다")
            let confirmAction = UIAlertAction(title: "OK", style: .default)
            self.delegate?.alert(controller: alertController, actions: [confirmAction])
        }

        let cancelAction = UIAlertAction(title: "취소", style: .cancel)
        delegate?.alert(controller: alertController, actions: [confirmAction, cancelAction])
    }

    private func hasPassedCouponExpiredDate(date stringDate: String) -> Bool? {
        let couponExpiredDateWithTime = stringDate.dateConvertable()
        let formattedCouponExpiredDate = couponExpiredDateWithTime.convertToDate()

        let date = Date()
        let currentDateString = date.convertToString()
        let formattedCurrentDate = currentDateString.convertToDate()

        guard let currentDate = formattedCurrentDate,
              let couponExpiredDate = formattedCouponExpiredDate else { return nil }

        return currentDate > couponExpiredDate
    }
}

// MARK: - Network
extension CouponBottomView {
    private func fetchCouponValidCode(id: Int, completion: @escaping (ValidInfo?) -> Void) {
        API<EventValid>(requestString: FoorunRequest.Event.event + "/\(id)" + "/validCheck", method: .get, parameters: [: ]).fetch { response in
            guard let eventValid = response.data else { return completion(nil) }
            completion(eventValid.data)
        }
    }

    private func deleteUsedCoupon(id: Int, completion: @escaping (DeleteCoupon?) -> Void) {
        API<DeleteCoupon>(requestString: FoorunRequest.Event.event + "/\(id)", method: .delete, parameters: [: ]).fetch { response in
            guard let deleteModel = response.data else { return completion(nil) }
            completion(deleteModel)
        }
    }
}
