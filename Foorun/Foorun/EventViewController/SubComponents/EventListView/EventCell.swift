//import UIKit
//import SnapKit
//import Kingfisher
//
//class EventCell: UICollectionViewCell {
//    //MARK: - Properties
//    static let identifier = String(describing: EventCell.self)
//    let sideEdgeInset = CGFloat(19.46)
//    let minLineSpacing = CGFloat(11.36)
//    lazy var cellWidth = (UIScreen.main.bounds.width - (2 * sideEdgeInset) - minLineSpacing) / 2 - 1
//    lazy var ratio = cellWidth / CGFloat(162.34)
//
//    //MARK: - SubComponents
//    private lazy var eventThumbnail: UIImageView = {
//        let imageView = UIImageView(image: UIImage())
//        imageView.contentMode = .scaleToFill
//        imageView.clipsToBounds = true
//        imageView.layer.cornerRadius = 12.3157 * ratio
//        imageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
//
//        return imageView
//    }()
//
//    private lazy var usedStampImage: UIImageView = {
//        let imageView = UIImageView(image: UIImage(named: "UsedStamp"))
//
//        return imageView
//    }()
//
//    private lazy var expiredStampImage: UIImageView = {
//        let imageView = UIImageView(image: UIImage(named: "ExpiredStamp"))
//
//        return imageView
//    }()
//
//    private lazy var eventThemeLabel: UILabel = {
//        let label = UILabel()
//        label.text = "이벤트 테마"
//        label.font = .appleGothicFont(ofSize: 16.681 * ratio, weight: .bold)
//        label.textColor = .black
//
//        return label
//    }()
//
//    private lazy var eventRestaurantLabel: UILabel = {
//        let label = UILabel()
//        label.text = "이벤트 진행 식당"
//        label.font = .appleGothicFont(ofSize: 12.511 * ratio, weight: .medium)
//        label.sizeToFit()
//        label.textColor = .black
//
//        return label
//    }()
//
//    private lazy var expiredDate: UILabel = {
//        let label = UILabel()
//        label.text = "~ 2022.01.01"
//        label.font = .appleGothicFont(ofSize: 12 * ratio, weight: .medium)
//        label.textColor = .lightGray
//
//        return label
//    }()
//
//    private lazy var unknownIssueLabel: UILabel = {
//        let label = UILabel()
//        label.text = "알 수 없는 오류"
//        label.font = .appleGothicFont(ofSize: 14 * ratio, weight: .semiBold)
//        label.textColor = .black
//
//        return label
//    }()
//
//    private lazy var overlayView = UIView()
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        layout()
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    override func prepareForReuse() {
//        super.prepareForReuse()
//        usedStampImage.isHidden = true
//        expiredStampImage.isHidden = true
//        unknownIssueLabel.isHidden = true
//        overlayView.isHidden = true
//    }
//}
//
////MARK: - Layout
//extension EventCell {
//    private func layout() {
//        self.backgroundColor = .white
//        self.contentView.layer.cornerRadius = 12.3157 * ratio
//        self.contentView.layer.masksToBounds = true
//        self.layer.shadowOffset = CGSize(width: 0, height: 0)
//        self.layer.shadowColor = UIColor.black.cgColor
//        self.layer.shadowRadius = 5
//        self.layer.cornerRadius = 12.3157 * ratio
//        self.layer.masksToBounds = false
//        self.layer.shadowOpacity = 0.07
//
//        addSubviews([eventThumbnail, eventThemeLabel, eventRestaurantLabel, expiredDate])
//
//        eventThumbnail.snp.makeConstraints {
//            $0.top.leading.trailing.equalToSuperview()
//            $0.height.equalTo(152.05 * ratio)
//        }
//
//        eventThemeLabel.snp.makeConstraints {
//            $0.top.equalTo(eventThumbnail.snp.bottom).offset(6.73 * ratio)
//            $0.leading.equalToSuperview().inset(10.82)
//            $0.height.equalTo(23 * ratio)
//        }
//
//        eventRestaurantLabel.snp.makeConstraints {
//            $0.top.equalTo(eventThemeLabel.snp.bottom).inset(0.92 * ratio)
//            $0.leading.equalTo(eventThemeLabel.snp.leading).inset(1.04)
//            $0.height.equalTo(16 * ratio)
//        }
//        eventRestaurantLabel.sizeToFit()
//
//        expiredDate.snp.makeConstraints {
//            $0.top.equalTo(eventRestaurantLabel.snp.bottom).offset(2.28 * ratio)
//            $0.leading.equalToSuperview().inset(11.86)
//            $0.bottom.equalToSuperview().inset(10.33 * ratio)
//        }
//    }
//
//    func configure(detail: Event.Detail) {
//        self.eventThemeLabel.text = detail.eventName
//        self.eventRestaurantLabel.text = detail.restaurantName
//        let formattedExpiredDate = detail.expiredDate.replacingOccurrences(of: "/", with: "-")
//        self.expiredDate.text = formattedExpiredDate
//
//        let imageURL = URL(string: detail.imageURL ?? "")
//        eventThumbnail.kf.setImage(with: imageURL, placeholder: nil)
//
//        if let used = UserDefaults.standard.array(forKey: "UsedCoupons") as? [Int],
//           used.contains(detail.id) {
//            layoutOverlayView()
//            layoutUsedStampImage()
//            return
//        }
//
//        guard let hasPassedExpiredDate = hasPassedEventExpiredDate(date: detail.expiredDate) else {
//            return
//        }
//
//        if hasPassedExpiredDate {
//            layoutOverlayView()
//            layoutExpiredStampImage()
//        }
//    }
//
//    private func hasPassedEventExpiredDate(date stringDate: String) -> Bool? {
//        let couponExpiredDateWithTime = stringDate.dateConvertable()
//        let formattedCouponExpiredDate = couponExpiredDateWithTime.convertToDate()
//
//        let date = Date()
//        let currentDateString = date.convertToString()
//        let formattedCurrentDate = currentDateString.convertToDate()
//
//        guard let currentDate = formattedCurrentDate,
//              let couponExpiredDate = formattedCouponExpiredDate else { return nil }
//
//        return currentDate > couponExpiredDate
//    }
//
//    private func layoutUsedStampImage() {
//        addSubview(usedStampImage)
//        usedStampImage.isHidden = false
//        usedStampImage.snp.makeConstraints {
//            $0.top.trailing.equalToSuperview().inset(10)
//            $0.width.equalToSuperview().multipliedBy(0.35)
//            $0.height.equalTo(usedStampImage.snp.width)
//        }
//    }
//
//    private func layoutExpiredStampImage() {
//        addSubview(expiredStampImage)
//        expiredStampImage.isHidden = false
//        expiredStampImage.snp.makeConstraints {
//            $0.top.trailing.equalToSuperview().inset(10)
//            $0.width.equalToSuperview().multipliedBy(0.35)
//            $0.height.equalTo(usedStampImage.snp.width)
//        }
//    }
//
//    private func layoutUnknownIssueLabel() {
//        addSubview(unknownIssueLabel)
//        unknownIssueLabel.isHidden = false
//        unknownIssueLabel.snp.makeConstraints {
//            $0.centerX.centerY.equalToSuperview()
//        }
//    }
//
//    private func layoutOverlayView() {
//        overlayView.isUserInteractionEnabled = false
//        overlayView.backgroundColor = .black.withAlphaComponent(0.5)
//        overlayView.layer.cornerRadius = 12.3157 * ratio
//
//        addSubview(overlayView)
//        overlayView.isHidden = false
//        overlayView.snp.makeConstraints {
//            $0.edges.equalToSuperview()
//        }
//    }
//}
