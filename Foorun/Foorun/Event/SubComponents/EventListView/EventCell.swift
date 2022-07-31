import UIKit
import SnapKit

class EventCell: UICollectionViewCell {
    //MARK: - Properties
    static let identifier = String(describing: EventCell.self)
    let sideEdgeInset = CGFloat(19.46)
    let minLineSpacing = CGFloat(11.36)
    lazy var cellWidth = (UIScreen.main.bounds.width - (2 * sideEdgeInset) - minLineSpacing) / 2 - 1
    lazy var ratio = cellWidth / CGFloat(162.34)

    //MARK: - SubComponents
    private lazy var eventThumbnail: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "EmoiEventPoster"))
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 12.3157
        imageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]

        return imageView
    }()

    private lazy var eventThemeLabel: UILabel = {
        let label = UILabel()
        label.text = "이벤트 테마"
        label.font = .appleGothicFont(ofSize: 16.681 * ratio, weight: .bold)
        label.textColor = .black

        return label
    }()

    private lazy var eventRestaurantLabel: UILabel = {
        let label = UILabel()
        label.text = "이벤트 진행 식당"
        label.font = .appleGothicFont(ofSize: 12.511 * ratio, weight: .medium)
        label.sizeToFit()
        label.textColor = .black

        return label
    }()

    private lazy var endDate: UILabel = {
        let label = UILabel()
        label.text = "~ 2022.01.01"
        label.font = .appleGothicFont(ofSize: 12 * ratio, weight: .medium)
        label.textColor = .lightGray

        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Layout
extension EventCell {
    private func layout() {
        self.backgroundColor = .white
        self.contentView.layer.cornerRadius = 12.3157 * ratio
        self.contentView.layer.masksToBounds = true
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowRadius = 5
        self.layer.cornerRadius = 12.3157 * ratio
        self.layer.masksToBounds = false
        self.layer.shadowOpacity = 0.07

        addSubviews([eventThumbnail, eventThemeLabel, eventRestaurantLabel, endDate])

        eventThumbnail.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(152.05 * ratio)
        }

        eventThemeLabel.snp.makeConstraints {
            $0.top.equalTo(eventThumbnail.snp.bottom).offset(6.73 * ratio)
            $0.leading.equalToSuperview().inset(10.82)
            $0.height.equalTo(23 * ratio)
        }

        eventRestaurantLabel.snp.makeConstraints {
            $0.top.equalTo(eventThemeLabel.snp.bottom).inset(0.92 * ratio)
            $0.leading.equalTo(eventThemeLabel.snp.leading).inset(1.04)
            $0.height.equalTo(16 * ratio)
        }
        eventRestaurantLabel.sizeToFit()

        endDate.snp.makeConstraints {
            $0.top.equalTo(eventRestaurantLabel.snp.bottom).offset(2.28 * ratio)
            $0.leading.equalToSuperview().inset(11.86)
            $0.bottom.equalToSuperview().inset(10.33 * ratio)
        }
    }
}
