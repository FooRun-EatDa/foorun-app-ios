//
//  EventViewController.swift
//  Foorun
//
//  Created by SeYeong on 2022/08/17.
//

// TODO: - 흑백이미지
// FIXME: - LargeTitle 버그

import UIKit
import SnapKit
import FoorunKey

class EventViewController: UIViewController {

    // MARK: - Properties

    @UserDefault(key: "UsedCoupons", defaultValue: [])
    var usedCoupons: Set<Int>

    var events: [Event] = Event.dummyModel {
        didSet {
            updateEvents()
        }
    }

    // MARK: - IBOutlets

    let eventView = EventView()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        eventView.collectionView.dataSource = self
        eventView.collectionView.delegate = self

        setupNavigationBar()
        setupViews()
        updateEvents()
        fetchEvents(page: 0)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        eventView.collectionView.reloadData()
    }

    // MARK: - Methods

    func setupNavigationBar() {
        self.navigationController?.navigationBar.backgroundColor = .white
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.title = "이벤트"
    }

    func setupViews() {
        view.backgroundColor = .white
        view.addSubview(eventView)

        eventView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }

    func updateEvents() {
        eventView.collectionView.isHidden = events.isEmpty
        ? true
        : false
        eventView.collectionView.reloadData()
    }

    private func fetchEvents(page: Int) {
        API<[Event]>(requestString: FoorunRequest.Event.event, method: .get, parameters: ["page": "\(page)"]).fetch { [weak self] response in
            guard let events = response.data else { return }
            self?.events = events
        }
    }

    func checkCouponType(event: Event) -> CouponType {
        guard let _ = UserDefaults.standard.string(forKey: "token") else {

            return .needLogin
        }

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yy/MM/dd hh:mm"
        guard let date = dateFormatter.date(from: event.date) else {

            return .expired
        }

        let currentDate = Date()
        if currentDate >= date {

            return .expired
        }

        return usedCoupons.contains(event.id)
        ? .used
        : .available
    }
}

@propertyWrapper
struct UserDefault<T: Codable> {
    private let key: String
    private let defaultValue: T
    public let storage: UserDefaults

    init(key: String, defaultValue: T, storage: UserDefaults = .standard) {
        self.key = key
        self.defaultValue = defaultValue
        self.storage = storage
    }

    var wrappedValue: T {
        get {
            guard let data = self.storage.object(forKey: key) as? Data else {
                return defaultValue
            }

            let value = try? JSONDecoder().decode(T.self, from: data)
            return value ?? defaultValue
        }
        set {
            let data = try? JSONEncoder().encode(newValue)

            UserDefaults.standard.set(data, forKey: key)
        }
    }
}
