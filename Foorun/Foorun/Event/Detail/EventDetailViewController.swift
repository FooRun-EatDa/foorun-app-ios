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
        }
    }

    private func deleteUsedCoupon(id: Int) {
        API<String>(
            requestString: FoorunRequest.Event.event + "\(id)",
            method: .delete,
            parameters: [:]).fetch { _ in }
    }
}

extension EventDetailViewController: EventDetailViewDelegate {
    func alert(controller: UIAlertController, actions: [UIAlertAction]) {
        self.showsAlert(controller: controller, actions: actions)
    }

    func updateCouponType(id: Int, completion: @escaping (CouponType) -> Void) {
        guard let event = event else {
            completion(.expired)
            return
        }

        CouponType.checkCouponType(event: event) { [weak self] couponType in
            switch couponType {
            case .available:
                UserDefaultManager.shared.usedCoupons.insert(id)
                DispatchQueue.global(qos: .background).async {
                    self?.deleteUsedCoupon(id: id)
                }
                completion(.available)
            case .expired:
                completion(.expired)
            case .선착순_마감:
                completion(.선착순_마감)
            default:
                completion(.needLogin)
            }
        }
    }
}
