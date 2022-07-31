import UIKit
import SnapKit

class EventDescriptionView: UIView {
    //MARK: - Property
    private var eventInfo: EventInfo?

    //MARK: - Subcomponents
    private lazy var eventRestaurantLabel: UILabel = {
        let label = UILabel()
        label.text = eventInfo?.restaurantName ?? ""
        label.font = UIFont.appleGothicFont(ofSize: 15, weight: .medium)
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 1

        return label
    }()

    private lazy var eventThemeLabel: UILabel = {
        let label = UILabel()
        label.text = eventInfo?.eventName ?? ""
        label.font = UIFont.appleGothicFont(ofSize: 21, weight: .semiBold)
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 1

        return label
    }()

    private lazy var endDateTitleLabel: UILabel = {
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
        label.text = "~ \(eventInfo?.expiredDate ?? "")"
        label.font = UIFont.appleGothicFont(ofSize: 13, weight: .regular)
        label.textColor = .systemBlue
        label.textAlignment = .left
        label.numberOfLines = 1

        return label
    }()

    private lazy var eventDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = eventInfo?.description ?? ""
        label.font = UIFont.appleGothicFont(ofSize: 13, weight: .regular)
        label.textColor = .black
        label.numberOfLines = 0

        return label
    }()

    private lazy var eventNoticeTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "이벤트 유의사항"
        label.font = UIFont.appleGothicFont(ofSize: 13, weight: .regular)
        label.textColor = .black

        return label
    }()

    private lazy var eventNoticeDetailTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(EventNoticeDescriptionCell.self, forCellReuseIdentifier: EventNoticeDescriptionCell.identifier)
        tableView.backgroundColor = .systemYellow
        tableView.allowsSelection = false
        tableView.dataSource = self
        tableView.delegate = self

        return tableView
    }()

    init(eventInfo: EventInfo?) {
        self.eventInfo = eventInfo
        super.init(frame: .zero)
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        eventNoticeDetailTableView.separatorStyle = .none
    }
}

//MARK: - Layout
extension EventDescriptionView {
    private func layout() {
        addSubviews([eventRestaurantLabel, eventThemeLabel, endDateTitleLabel, expiredDateLabel, eventDescriptionLabel, eventNoticeTitleLabel, eventNoticeDetailTableView])

        eventRestaurantLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().inset(23.5)
            $0.height.equalTo(16.23)
        }

        eventThemeLabel.snp.makeConstraints {
            $0.top.equalTo(eventRestaurantLabel.snp.bottom).offset(12.35)
            $0.leading.equalTo(eventRestaurantLabel)
        }

        endDateTitleLabel.snp.makeConstraints {
            $0.top.equalTo(eventThemeLabel.snp.bottom).offset(27.92)
            $0.leading.equalTo(eventThemeLabel)
            $0.width.equalTo(45)
            $0.height.equalTo(17)
        }

        expiredDateLabel.snp.makeConstraints {
            $0.top.equalTo(endDateTitleLabel)
            $0.leading.equalTo(endDateTitleLabel.snp.trailing).offset(5.07)
            $0.height.equalTo(17)
        }

        eventDescriptionLabel.snp.makeConstraints {
            $0.top.equalTo(endDateTitleLabel.snp.bottom).offset(23.44)
            $0.leading.equalTo(endDateTitleLabel)
            $0.trailing.equalToSuperview().inset(20.64)
        }

        eventNoticeTitleLabel.snp.makeConstraints {
            $0.top.equalTo(eventDescriptionLabel.snp.bottom).offset(23.44)
            $0.leading.equalTo(eventDescriptionLabel)
        }

        eventNoticeDetailTableView.snp.makeConstraints {
            $0.top.equalTo(eventNoticeTitleLabel.snp.bottom).offset(3.96)
            $0.leading.equalTo(eventNoticeTitleLabel)
            $0.trailing.equalToSuperview().inset(20.64)
            $0.height.equalTo(cellHeight * CGFloat(eventInfo?.notices.count ?? 0))
            $0.bottom.equalToSuperview()
        }
    }
}

//MARK: - TableViewDatasource
extension EventDescriptionView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let notices = eventInfo?.notices

        return notices?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: EventNoticeDescriptionCell.identifier, for: indexPath) as? EventNoticeDescriptionCell,
              let notices = eventInfo?.notices else { return UITableViewCell() }

        cell.configure(notice: notices[indexPath.row])

        return cell
    }
}

//MARK: - TableViewDelegate
extension EventDescriptionView: UITableViewDelegate {
    var cellHeight: CGFloat {

        return 17
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        return cellHeight
    }
}
