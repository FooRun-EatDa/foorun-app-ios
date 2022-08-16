import UIKit
import SnapKit

class EventDescriptionView: UIView {
    //MARK: - Property
    private var eventInfo: Event.Detail

    //MARK: - Subcomponents
    private lazy var eventRestaurantLabel: UILabel = {
        let label = UILabel()
        label.text = eventInfo.restaurantName
        label.font = UIFont.appleGothicFont(ofSize: 15, weight: .medium)
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 1

        return label
    }()

    private lazy var eventThemeLabel: UILabel = {
        let label = UILabel()
        label.text = eventInfo.eventName ?? ""
        label.font = UIFont.appleGothicFont(ofSize: 21, weight: .semiBold)
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 1

        return label
    }()

    private lazy var expiredDateTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "종료날짜"
        label.font = UIFont.appleGothicFont(ofSize: 13, weight: .regular)
        label.textColor = .lightGray
        label.textAlignment = .left
        label.numberOfLines = 1

        return label
    }()

    private lazy var expiredDateLabel: UILabel = {
        let label = UILabel()
        label.text = "~ \(eventInfo.expiredDate)"
        label.font = UIFont.appleGothicFont(ofSize: 13, weight: .regular)
        label.textColor = .systemBlue
        label.textAlignment = .left
        label.numberOfLines = 1

        return label
    }()

    private lazy var eventDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = eventInfo.description ?? ""
        label.font = UIFont.appleGothicFont(ofSize: 13, weight: .regular)
        label.textColor = .black
        label.numberOfLines = 0

        return label
    }()

    private lazy var eventNoticeTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "이벤트 유의사항"
        label.textColor = .lightGray
        label.font = UIFont.appleGothicFont(ofSize: 13, weight: .regular)

        return label
    }()

    private lazy var eventNoticesLabel: UILabel = {
        let label = UILabel()
        label.text = makeNoticesToOneString()
        label.font = UIFont.appleGothicFont(ofSize: 13, weight: .regular)
        label.textColor = .black
        label.numberOfLines = 0
        label.paragraphSpacing = 7.96

        return label
    }()

    init(eventInfo: Event.Detail) {
        self.eventInfo = eventInfo
        super.init(frame: .zero)
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Layout
extension EventDescriptionView {
    private func layout() {
        addSubviews([eventRestaurantLabel, eventThemeLabel, expiredDateTitleLabel, expiredDateLabel, eventDescriptionLabel, eventNoticeTitleLabel, eventNoticesLabel])

        eventRestaurantLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().inset(23.5)
            $0.height.equalTo(16.23)
        }

        eventThemeLabel.snp.makeConstraints {
            $0.top.equalTo(eventRestaurantLabel.snp.bottom).offset(12.35)
            $0.leading.equalTo(eventRestaurantLabel)
        }

        expiredDateTitleLabel.snp.makeConstraints {
            $0.top.equalTo(eventThemeLabel.snp.bottom).offset(27.92)
            $0.leading.equalTo(eventThemeLabel)
            $0.width.equalTo(45)
            $0.height.equalTo(17)
        }

        expiredDateLabel.snp.makeConstraints {
            $0.top.equalTo(expiredDateTitleLabel)
            $0.leading.equalTo(expiredDateTitleLabel.snp.trailing).offset(5.07)
            $0.height.equalTo(17)
        }

        eventDescriptionLabel.snp.makeConstraints {
            $0.top.equalTo(expiredDateTitleLabel.snp.bottom).offset(23.44)
            $0.leading.equalTo(expiredDateTitleLabel)
            $0.trailing.equalToSuperview().inset(20.64)
        }

        eventNoticeTitleLabel.snp.makeConstraints {
            $0.top.equalTo(eventDescriptionLabel.snp.bottom).offset(23.44)
            $0.leading.equalTo(eventDescriptionLabel)
        }

        eventNoticesLabel.snp.makeConstraints {
            $0.top.equalTo(eventNoticeTitleLabel.snp.bottom).offset(7.96)
            $0.leading.equalTo(eventNoticeTitleLabel)
            $0.trailing.equalToSuperview().inset(20.64)
            $0.bottom.equalToSuperview()
        }
    }

    private func makeNoticesToOneString() -> String {
        guard let notices = eventInfo.notices else { return "" }

        return notices.map { "· \($0)\n" }.reduce("", +).trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
