import UIKit
import SnapKit

protocol CouponViewDelegate {
    func alert(model: UIAlertController.alertModel)
    func dismiss()
}

class CouponBottomView: UIView {
    //MARK: - Properties
    let eventID: Int?
    let expiredDate: String?
    let isLogin: Bool

    var couponViewDelegate: CouponViewDelegate?

    //MARK: - SubComponents
    private lazy var couponButton: UIButton = {
        let button = UIButton()
        button.setTitle("로그인 후 사용가능합니다", for: .normal)
        button.titleLabel?.tintColor = .white
        button.titleLabel?.font = .systemFont(ofSize: 15.47, weight: .bold)
        button.backgroundColor = UIColor.lightGray
        button.isEnabled = false
        button.layer.cornerRadius = 9
        button.addTarget(self, action: #selector(tappedCouponButton), for: .touchUpInside)

        return button
    }()

    init(eventID: Int?, expiredDate: String?, isLogin: Bool = true) {
        self.eventID = eventID
        self.expiredDate = expiredDate
        self.isLogin = isLogin
        super.init(frame: .zero)
        layout()
        addNotificationObserver(name: "DidUseCoupon")
        layoutCouponBtnByFetchingValidCode()
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
        layoutCouponButton(type: .available)
    }

    private func layoutCouponButton(type: CouponType) {
        couponButton.setTitle(type.title, for: .normal)
        couponButton.backgroundColor = type.bgColor
        couponButton.isEnabled = type.touchEnable
    }
}

//MARK: - Layout By Network
extension CouponBottomView {
    private func layoutCouponBtnByFetchingValidCode() {
        guard let eventID = eventID else { return }
        let networkManger = EventNetworkManager(apiType: .validCheck(id: eventID))
        
        networkManger.fetchCouponValidCode { [weak self] result in
            guard let self = self else { return }

            DispatchQueue.main.async {
                switch result {
                case .success(let eventValid):
                    let validCode = eventValid.data.status
                    switch validCode {
                    case 0:
                        self.layoutCouponButton(type: .available)
                    case 1:
                        self.layoutCouponButton(type: .expired)
                    case 2:
                        self.layoutCouponButton(type: .used)
                    default:
                        fatalError("Unknown Valid Code")
                    }
                case .failure(let error):
                    let alertModel = APIRequestManager.makeAlertModel(for: error)
                    self.couponViewDelegate?.alert(model: alertModel)
                }
            }
        }
    }

    @objc private func didUseCoupon(_ note: Notification) {
        guard let eventID = eventID else { return }
        let networkManger = EventNetworkManager(apiType: .useCoupon(id: eventID))

        networkManger.deleteCoupon { [weak self] error in
            DispatchQueue.main.async {
                guard let error = error,
                      let self = self else { return }

                let alertModel = APIRequestManager.makeAlertModel(for: error)
                self.couponViewDelegate?.alert(model: alertModel)
            }
        }
    }
}

//MARK: - Handling Coupon Tapped Action
extension CouponBottomView {
    @objc private func tappedCouponButton() {
        guard let cannotUseCoupon = hasPassedCouponExpiredDate(date: expiredDate) else { return }
        let canUseCoupon = !cannotUseCoupon

        if canUseCoupon {
            let alertModel = UIAlertController.alertModel(
                title: "쿠폰을 사용하시겠습니까?",
                yesTitle: "예",
                yesHandler: { _ in
                    NotificationCenter.default.post(name: NSNotification.Name("DidUseCoupon"), object: nil)
                    self.couponViewDelegate?.dismiss()
                },
                noTitle: "아니오",
                noHandler: { _ in self.couponViewDelegate?.dismiss() })

            couponViewDelegate?.alert(model: alertModel)
        } else {
            let alertModel = UIAlertController.alertModel(
                title: "이벤트가 종료되었습니다.",
                yesTitle: "OK",
                yesHandler: { _ in self.couponViewDelegate?.dismiss() })

            couponViewDelegate?.alert(model: alertModel)
        }
    }

    private func hasPassedCouponExpiredDate(date stringDate: String?) -> Bool? {
        guard let stringDate = stringDate else { return nil }

        let couponExpiredDateWithTime = stringDate + " 23:59:00"
        let formattedCouponExpiredDate = couponExpiredDateWithTime.convertToDate()

        let date = Date()
        let currentDateString = date.convertToString()
        let formattedCurrentDate = currentDateString.convertToDate()

        guard let currentDate = formattedCurrentDate,
              let couponExpiredDate = formattedCouponExpiredDate else { return nil }

        return currentDate > couponExpiredDate
    }

    private func addNotificationObserver(name: String) {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(didUseCoupon(_:)),
            name: NSNotification.Name(name),
            object: nil)
    }
}
