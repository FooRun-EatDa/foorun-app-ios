//
//  EventDetailView.swift
//  Foorun
//
//  Created by SeYeong on 2022/08/17.
//

import UIKit
import SnapKit
import Kingfisher
import FoorunKey

protocol EventDetailViewDelegate: AnyObject {
    func alert(controller: UIAlertController, actions: [UIAlertAction])
    func updateCouponType(id: Int, completion: @escaping (CouponType) -> Void)
}

class EventDetailView: UIView {
    // MARK: - Properties

    weak var delegate: EventDetailViewDelegate?
    var id: Int?

    // MARK: - IBOutlets

    let scrollView = UIScrollView()
    let contentView = UIView()
    var bannerImageView = UIImageView()
    var restaurantTitleLabel = UILabel()
    var themeLabel = UILabel()
    let dateTitleLabel = UILabel()
    var dateLabel = UILabel()
    var descriptionLabel = UILabel()
    let warningLabel = UILabel()
    var warningDescriptionLabel = UILabel()
    var buttonContainerView = UIView()
    var couponButton = UIButton()
    var stampImageView = UIImageView()
    var overlayView = UIView()

    // MARK: - Life Cycle

    override init(frame: CGRect) {
        super.init(frame: .zero)

        setupScrollView()
        setupButtonContainerView()
        setupOverlayView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Methods

    func setUI(_ item: Event?, _ type: CouponType?) {
        guard let item = item,
              let type = type else { return }
        self.id = item.id

        let imageURL = URL(string: item.imageURL ?? "")
        bannerImageView.kf.setImage(with: imageURL, placeholder: UIImage(named: "bannerPlaceholder"))
        themeLabel.text = item.eventName
        restaurantTitleLabel.text = item.restaurantName
        dateLabel.text = item.date
        descriptionLabel.text = item.description
        warningDescriptionLabel.text = warningsToString(item.warnings)
        updateCouponButton(type: type)
    }

    private func updateCouponButton(type: CouponType) {
        couponButton.setTitle(type.rawValue, for: .normal)
        couponButton.backgroundColor = type.backgroundColor()
        couponButton.isEnabled = type.isEnable()
    }
}

extension EventDetailView {
    var leading: CGFloat { return 24 }
    var trailing: CGFloat { return 21 }

    private func setupButtonContainerView() {
        addSubview(buttonContainerView)

        buttonContainerView.backgroundColor = .white
        buttonContainerView.layer.shadowColor = UIColor.black.cgColor
        buttonContainerView.layer.shadowOffset = .zero
        buttonContainerView.layer.shadowOpacity = 0.3
        buttonContainerView.layer.shadowRadius = 5

        buttonContainerView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(105)
        }

        buttonContainerView.addSubview(couponButton)

        couponButton.setTitle("👍 쿠폰 사용하기", for: .normal)
        couponButton.titleLabel?.font = .systemFont(ofSize: 15, weight: .bold)
        couponButton.backgroundColor = .systemYellow
        couponButton.layer.cornerRadius = 9
        couponButton.addTarget(self, action: #selector(didTapCouponButton), for: .touchUpInside)

        couponButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(15)
            $0.leading.trailing.equalToSuperview().inset(35)
            $0.height.equalTo(50)
        }
    }

    private func setupScrollView() {
        addSubview(scrollView)

        backgroundColor = .white

        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        setupContentView()
    }

    private func setupContentView() {
        scrollView.addSubview(contentView)

        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
        }

        setupBannerImageView()
        setupThemeLabel()
        setupRestaurantTitleLabel()
        setupDateTitleLable()
        setupDateLabel()
        setupDescriptionLabel()
        setupWarningLabel()
        setupWarningDescriptionLabel()
        setupOverlayView()
    }

    private func setupBannerImageView() {
        contentView.addSubview(bannerImageView)

        bannerImageView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(bannerImageView.snp.width).multipliedBy(1.4)
        }
    }

    private func setupThemeLabel() {
        contentView.addSubview(themeLabel)

        themeLabel.font = .systemFont(ofSize: 15, weight: .medium)

        themeLabel.snp.makeConstraints {
            $0.top.equalTo(bannerImageView.snp.bottom).offset(27)
            $0.leading.equalToSuperview().inset(leading)
            $0.trailing.equalToSuperview().inset(trailing)
            $0.height.equalTo(16)
        }
    }

    private func setupRestaurantTitleLabel() {
        contentView.addSubview(restaurantTitleLabel)

        restaurantTitleLabel.font = .systemFont(ofSize: 21, weight: .semibold)

        restaurantTitleLabel.snp.makeConstraints {
            $0.top.equalTo(themeLabel.snp.bottom).offset(12)
            $0.leading.equalToSuperview().inset(leading)
            $0.trailing.equalToSuperview().inset(trailing)
        }
    }

    private func setupDateTitleLable() {
        contentView.addSubview(dateTitleLabel)

        dateTitleLabel.text = "종료 날짜 ~ "
        dateTitleLabel.font = .systemFont(ofSize: 13, weight: .regular)
        dateTitleLabel.textColor = .lightGray

        dateTitleLabel.snp.makeConstraints {
            $0.top.equalTo(restaurantTitleLabel.snp.bottom).offset(28)
            $0.leading.equalToSuperview().inset(leading)
            $0.height.equalTo(17)
        }
    }

    private func setupDateLabel() {
        contentView.addSubview(dateLabel)

        dateLabel.font = .systemFont(ofSize: 13, weight: .regular)
        dateLabel.textColor = .lightGray

        dateLabel.snp.makeConstraints {
            $0.top.equalTo(dateTitleLabel)
            $0.leading.equalTo(dateTitleLabel.snp.trailing)
            $0.height.equalTo(17)
        }
    }

    private func setupDescriptionLabel() {
        contentView.addSubview(descriptionLabel)

        descriptionLabel.font = .systemFont(ofSize: 13, weight: .regular)
        descriptionLabel.numberOfLines = 0

        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(dateTitleLabel.snp.bottom).offset(23)
            $0.leading.equalToSuperview().inset(leading)
            $0.trailing.equalToSuperview().inset(trailing)
        }
    }

    private func setupWarningLabel() {
        contentView.addSubview(warningLabel)

        warningLabel.text = "이벤트 유의사항"
        warningLabel.textColor = .lightGray
        warningLabel.font = .systemFont(ofSize: 13, weight: .regular)

        warningLabel.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(23)
            $0.leading.equalToSuperview().inset(leading)
        }
    }

    private func setupWarningDescriptionLabel() {
        contentView.addSubview(warningDescriptionLabel)

        warningDescriptionLabel.font = .systemFont(ofSize: 13, weight: .regular)
        warningDescriptionLabel.numberOfLines = 0

        warningDescriptionLabel.snp.makeConstraints {
            $0.top.equalTo(warningLabel.snp.bottom).offset(8)
            $0.leading.equalToSuperview().inset(leading)
            $0.trailing.equalToSuperview().inset(trailing)
            $0.bottom.equalToSuperview().inset(130)
        }
    }

    private func setupOverlayView() {
        addSubview(overlayView)

        overlayView.backgroundColor = .black.withAlphaComponent(0.5)
        overlayView.isUserInteractionEnabled = false
        overlayView.isHidden = true

        overlayView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    @objc
    private func didTapCouponButton() {
        guard let id = id else { return }

        let alertController: UIAlertController = .init(title: "*주의*\n해당 쿠폰은 사용 즉시 소멸되며, 소비자가 아닌 이벤트 진행 중인 식당의 점원 혹은 점주가 사용 승인하는 쿠폰입니다. 진행하시겠습니까?", message: nil)

        let confirmAction = UIAlertAction(title: "사용", style: .destructive) { [weak self] action in
            self?.delegate?.updateCouponType(id: id) { updatedCouponType in
                var alertMessage = "오류가 발생했어요.. 😂"
                switch updatedCouponType {
                case .expired:
                    alertMessage = "쿠폰이 만료되었어요..ㅠ 😂"
                    self?.updateCouponButton(type: .expired)
                case .available:
                    alertMessage = "쿠폰이 사용되었습니다! 😄"
                    self?.updateCouponButton(type: .used)
                case .선착순_마감:
                    alertMessage = "선착순 마감되었어요.. 😂"
                    self?.updateCouponButton(type: .선착순_마감)
                default :
                    alertMessage = "오류가 발생했어요.. 😂"
                    self?.updateCouponButton(type: .available)
                }

                let alertController: UIAlertController = .init(title: alertMessage, message: nil)
                let confirmAction = UIAlertAction(title: "확인", style: .default)
                self?.delegate?.alert(controller: alertController, actions: [confirmAction])
            }
        }
        let cancelAction = UIAlertAction(title: "취소", style: .cancel)

        self.delegate?.alert(controller: alertController, actions: [confirmAction, cancelAction])
    }

    private func warningsToString(_ strings: [String]?) -> String {
        guard let strings = strings else { return "" }

        return strings.map { "· \($0)\n" }
            .reduce("", +)
            .trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
