//
//  EventDetailViewController.swift
//  Foorun
//
//  Created by SeYeong on 2022/08/17.
//

import UIKit
import SnapKit
import FoorunKey

class EventDetailViewController: UIViewController {
    
    // MARK: - Properties

    var event: Event?
    var couponType: CouponType?

    // MARK: - IBOutlet

    var eventDetailView = EventDetailView()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupEventDetailView()
        setupNavigationBar()
        eventDetailView.setUI(event, couponType)
        eventDetailView.delegate = self
    }

    private func setupNavigationBar() {
        navigationController?.navigationBar.topItem?.backButtonDisplayMode = .minimal
        navigationController?.navigationBar.tintColor = .black
    }

    // MARK: - Methods
    
    func setupEventDetailView() {
        view.addSubview(eventDetailView)

        view.backgroundColor = .white

        eventDetailView.backgroundColor = .clear
        eventDetailView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.bottom.equalToSuperview()
            $0.width.equalToSuperview()
        }
    }

    private func deleteUsedCoupon(id: Int) {
        API<String>(
            requestString: FoorunRequest.Event.event + "\(id)",
            method: .delete,
            parameters: [: ]).fetch { _ in }
    }

    private func isEventValid(id: Int) -> Bool {
        var isValid: Bool = false

        API<EventValid>(
            requestString: FoorunRequest.Event.event + "\(id)/validCheck",
                        method: .get,
                        parameters: [: ]).fetch { result in
            switch result {
            case .success(let eventValid):
                switch eventValid.data?.status {
                case 0:
                    isValid = true
                default:
                    isValid = false
                }
            case .failure(_):
                isValid = false
            }
        }

        return isValid
    }
}

extension EventDetailViewController: EventDetailViewDelegate {
    func alert(controller: UIAlertController, actions: [UIAlertAction]) {
        self.showsAlert(controller: controller, actions: actions)
    }

    func updateCouponType(id: Int) -> CouponType {
        guard let event = event else { return .expired }

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yy/MM/dd hh:mm"
        let currentDate = Date()

        guard let date = dateFormatter.date(from: event.date),
              currentDate >= date else {

            return .expired
        }

        if isEventValid(id: id) {
            @UserDefault(key: "UsedCoupons", defaultValue: [])
            var usedCoupons: Set<Int>
            usedCoupons.insert(id)

            return .used
        } else {

            return .finished
        }
    }
}
