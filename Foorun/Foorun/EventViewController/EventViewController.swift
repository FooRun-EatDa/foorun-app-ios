//import UIKit
//import SnapKit
//import FoorunKey
//
//class EventViewController: UIViewController {
//    //MARK: - Properties
//    var eventDetails: [Event.Detail] = []
//
//    //MARK: - Subcomponents
//    private lazy var eventHeaderView = EventHeaderView()
//    private lazy var eventListView = EventListView()
//    private lazy var noEventNoticeView = NoEventNoticeView()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        eventListView.delegate = self
//        handlingFetchedEventDetails(of: 0)
//    }
//
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        layout()
//        eventListView.reloadData()
//    }
//}
//
////MARK: - Layout
//extension EventViewController {
//    private func layoutNavigationBar() {
////        let bellWithBadgeImage = UIImage(systemName: "bell.badge")?.withRenderingMode(.alwaysOriginal)
////
////        navigationController?.navigationBar.tintColor = .white
////        navigationItem.rightBarButtonItem = UIBarButtonItem(image: bellWithBadgeImage, style: .done, target: nil, action: nil)
//    }
//
//    private func layout() {
//        view.backgroundColor = UIColor(named: "EventVCBgColor")
//        view.addSubviews([eventHeaderView, noEventNoticeView, eventListView])
//
//        eventHeaderView.backgroundColor = UIColor(named: "EventVCBgColor")
//        eventHeaderView.snp.makeConstraints {
//            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20.8)
//            $0.leading.trailing.equalToSuperview()
//            $0.height.equalTo(35)
//        }
//
//        eventListView.snp.makeConstraints {
//            $0.top.equalTo(eventHeaderView.snp.bottom).offset(16.08)
//            $0.leading.trailing.bottom.equalToSuperview()
//            $0.width.equalToSuperview()
//        }
//
//        noEventNoticeView.snp.makeConstraints {
//            $0.edges.equalToSuperview()
//        }
//        noEventNoticeView.isHidden = true
//    }
//}
//
////MARK: - Network
//extension EventViewController {
//    private func handlingFetchedEventDetails(of page: Int) {
//        fetchEventDetails(page: page) { [weak self] newEventDetails in
//            guard let newEventDetails = newEventDetails,
//                  let self = self else { return }
//            self.eventDetails.append(contentsOf: newEventDetails)
//            self.eventListView.eventDetails = self.eventDetails
//        }
//    }
//
//    private func fetchEventDetails(page: Int, completion: @escaping ([Event.Detail]?) -> Void) {
//        let api = API<[Event.Detail]>(requestString: FoorunRequest.Event.event, method: .get, parameters: ["page": "\(page)"])
//        api.fetch { response in
//            guard let event = response.data else { return completion(nil) }
//            completion(event)
//        }
//    }
//}
//
//// MARK: - EventListDelegate
//extension EventViewController: EventListViewDelegate {
//    func eventDidSelected(info: Event.Detail) {
//        let viewController = EventDetailViewController(eventDetail: info)
//        navigationController?.pushViewController(viewController, animated: true)
//    }
//
//    func refreshEvent() {
//        handlingFetchedEventDetails(of: 0)
//        eventListView.endRefreshing()
//    }
//
//    func hideEventList(_ isHidden: Bool) {
//        eventListView.isHidden = isHidden
//        noEventNoticeView.isHidden = !isHidden
//    }
//}
