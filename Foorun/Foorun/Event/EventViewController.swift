//
//  EventViewController.swift
//  Foorun
//
//  Created by SeYeong on 2022/08/17.
//

import UIKit
import SnapKit
import FoorunKey

class EventViewController: UIViewController {

    // MARK: - Properties
    
    var events: [Event] = [] {
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
        fetchEvents(page: 1)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationItem.largeTitleDisplayMode = .always
        eventView.collectionView.reloadData()
    }

    // MARK: - Methods

    func setupNavigationBar() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.title = "이벤트"
    }

    func setupViews() {
        view.addSubview(eventView)

        eventView.backgroundColor = .white

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
        API<[Event]>(
            requestString: FoorunRequest.Event.event,
            method: .get,
            parameters: ["page": page]).fetchResult { [weak self] result in
            switch result {
            case .success(let response):
                guard let events = response.data else { return }
                self?.events = events
            case .failure(_):
                self?.events = []
            }
        }
    }
}

