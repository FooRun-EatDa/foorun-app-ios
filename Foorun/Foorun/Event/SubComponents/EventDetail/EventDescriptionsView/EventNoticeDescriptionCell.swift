import UIKit
import SnapKit

class EventNoticeDescriptionCell: UITableViewCell {
    //MARK: - Property
    static let identifier = String(describing: EventNoticeDescriptionCell.self)

    //MARK: - SubComponents
    private lazy var noticeLabel: UILabel = {
        let label = UILabel()
        label.text = "공지사항 1"
        label.font = UIFont.appleGothicFont(ofSize: 13, weight: .regular)
        label.textColor = .black
        label.numberOfLines = 0

        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Layout
extension EventNoticeDescriptionCell {
    private func layout() {
        contentView.backgroundColor = .white
        contentView.addSubview(noticeLabel)

        noticeLabel.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    func configure(notice: String) {
        noticeLabel.text = "· " + notice
    }
}
