//
//  EventDetailViewController.swift
//  Foorun
//
//  Created by SeYeong on 2022/08/17.
//

import UIKit
import SnapKit

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
        view.backgroundColor = .white
        view.addSubview(eventDetailView)

        eventDetailView.backgroundColor = .clear
        eventDetailView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.bottom.equalToSuperview()
            $0.width.equalToSuperview()
        }
    }
}

extension EventDetailViewController: EventDetailViewDelegate {
    func alert(controller: UIAlertController, actions: [UIAlertAction]) {
        self.showsAlert(controller: controller, actions: actions)
    }
}
