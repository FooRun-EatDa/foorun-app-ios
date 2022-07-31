import UIKit
import SnapKit

class EventHeaderView: UIView {
    //MARK: - SubComponents
    private lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.text = "이벤트"
        label.font = .appleGothicFont(ofSize: 25, weight: .bold)
        label.textColor = .black

        return label
    }()

    private lazy var eventNumbersLabel: UILabel = {
        let label = UILabel()
        label.text = "12"
        label.font = .appleGothicFont(ofSize: 25, weight: .regular)
        label.textColor = .systemYellow

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
extension EventHeaderView {
    private func layout() {
        addSubviews([headerLabel, eventNumbersLabel])

        headerLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().inset(22.54)
            $0.width.equalTo(65.61)
            $0.height.equalTo(34)
        }

        eventNumbersLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalTo(headerLabel.snp.trailing).offset(8.35)
            $0.width.equalTo(23)
            $0.height.equalTo(35)
            $0.bottom.equalToSuperview()
        }
    }
}
