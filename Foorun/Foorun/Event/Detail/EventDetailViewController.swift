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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationItem.largeTitleDisplayMode = .never
    }

    private func setupNavigationBar() {
        navigationController?.navigationBar.topItem?.backButtonDisplayMode = .minimal
        navigationController?.navigationBar.tintColor = .black
    }

    // MARK: - Methods
    
    func setupEventDetailView() {
        view.addSubview(eventDetailView)

        view.backgroundColor = .white

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

    private func 선착순마감(id: Int) -> Bool {
        var isValid: Bool = true

        API<EventValid>(
            requestString: FoorunRequest.Event.event + "\(id)/validCheck",
                        method: .get,
                        parameters: [: ]).fetchResult { result in
            switch result {
            case .success(let eventValid):
                switch eventValid.data?.status {
                case 0:
                    isValid = false
                default:
                    isValid = true
                }
            case .failure(_):
                isValid = true
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

        guard CouponType.isValidDate(event.date) else { return .expired }

        if CouponType.선착순_마감_여부(id: id) {

            return .선착순_마감
        } else {
            @UserDefault(key: "UsedCoupons", defaultValue: [])
            var usedCoupons: Set<Int>
            usedCoupons.insert(id)

            DispatchQueue.global(qos: .background).async {
                self.deleteUsedCoupon(id: id)
            }

            return .used
        }
    }
}
