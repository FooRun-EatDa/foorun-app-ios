import UIKit
import SnapKit

protocol HideEventList {
    func hideEventList(_ hide: Bool)
}

class EventViewController: UIViewController {
    //MARK: - Properties
    var events = [Event]()
    var fetchedPages = [Int]()
    var currentPage = 1
    var hideEventListDelegate: HideEventList?

    let dummyModel = DummyModel.dummyModel

    //MARK: - Subcomponents
    private lazy var eventHeaderView = EventHeaderView()

    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(nil, action: #selector(refresh), for: .valueChanged)

        return refreshControl
    }()

    private lazy var noEventLabel: UILabel = {
        let label = UILabel()
        label.text = "현재 진행중인 이벤트가 없습니다."
        label.font = .systemFont(ofSize: 21, weight: .semibold)
        label.isHidden = true
        label.isUserInteractionEnabled = false

        return label
    }()

    private lazy var eventCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.register(EventCell.self, forCellWithReuseIdentifier: EventCell.identifier)
        collectionView.backgroundColor = UIColor(named: "EventVCBgColor")
        collectionView.isScrollEnabled = true
        collectionView.alwaysBounceVertical = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.refreshControl = refreshControl

        return collectionView
    }()

    private lazy var flowLayout: UICollectionViewLayout = {
        let sideEdgeInset = CGFloat(19.46)
        let minLineSpacing = CGFloat(11.36)
        let minItemSpacing = CGFloat(11.73)
        let aspectRatio = 0.72
        let cellWidth = (UIScreen.main.bounds.width - (2 * sideEdgeInset) - minLineSpacing) / 2 - 1
        let cellHeight = cellWidth / aspectRatio

        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
        layout.sectionInset = UIEdgeInsets(top: 0, left: sideEdgeInset, bottom: 0, right: sideEdgeInset)
        layout.minimumLineSpacing = minLineSpacing
        layout.minimumInteritemSpacing = minItemSpacing

        return layout
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        hideEventListDelegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        layoutNavigationBar()
        layout()
        fetchEvent(of: 1)
    }
}

//MARK: - Layout
extension EventViewController {
    private func layoutNavigationBar() {
        let bellWithBadgeImage = UIImage(systemName: "bell.badge")?.withRenderingMode(.alwaysOriginal)

        navigationController?.navigationBar.tintColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: bellWithBadgeImage, style: .done, target: nil, action: nil)
    }

    private func layout() {
        view.backgroundColor = UIColor(named: "EventVCBgColor")
        view.addSubviews([eventHeaderView, eventCollectionView, noEventLabel])

        eventHeaderView.backgroundColor = UIColor(named: "EventVCBgColor")
        eventHeaderView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20.8)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(35)
        }

        eventCollectionView.snp.makeConstraints {
            $0.top.equalTo(eventHeaderView.snp.bottom).offset(16.08)
            $0.leading.trailing.bottom.equalToSuperview()
            $0.width.equalToSuperview()
        }

        noEventLabel.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
    }
}

extension EventViewController {
    @objc private func refresh() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.fetchEvent(of: 1)
            self.refreshControl.endRefreshing()
        }
    }
}

//MARK: - Network
extension EventViewController {
    private func fetchEvent(of page: Int) {
        guard fetchedPages.contains(page) == false else { return }

        EventNetworkManager.fetchEventList(page: page) { [weak self] result in
            guard let self = self else { return }

            DispatchQueue.main.async {
                switch result {
                case .success(let event):
                    self.events.append(event)
                    self.fetchedPages.append(page)
                    self.currentPage += 1
                    self.eventCollectionView.reloadData()

                case .failure(let error):
                    let alertModel = APIRequestManager.makeAlertModel(for: error)
                    self.showAlert(model: alertModel)
                    self.eventCollectionView.isHidden = true
                    self.noEventLabel.isHidden = false
                }
            }
        }
    }
}

//MARK: - CollectionView Datasource
extension EventViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var numberOfItems = 0
        events.map { numberOfItems += $0.eventInfos.count }

        numberOfItems == 0 ? (hideEventListDelegate?.hideEventList(true)) : (hideEventListDelegate?.hideEventList(false))

        return numberOfItems
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EventCell.identifier, for: indexPath) as? EventCell else { return UICollectionViewCell() }

        return cell
    }
}

extension EventViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        //        guard currentPage != 1 else { return }
        //        indexPaths.forEach { indexPath in
        //            if (indexPath.row + 1) / 10 + 1 == currentPage {
        //                self.fetchEvent(of: currentPage)
        //            }
        //        }
    }
}

extension EventViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        ///         만약 선택된 event의 indexPath.row가 12이라면
        ///         currentPage: (12 / 10) + 1 -> 2
        ///         해당 currentPage에서의 Index: 12 % 10 -> 2
        //        let page = indexPath.row / 10
        //        let infoIndex = (indexPath.row % 10)
        //        let seletedEventInfo = events[page].eventInfos[infoIndex]

        let selectedEventInfo = dummyModel[0].eventInfos[0]
        let eventDetailVC = EventDetailViewController(eventInfo: selectedEventInfo)
        navigationController?.pushViewController(eventDetailVC, animated: true)
    }
}

extension EventViewController: HideEventList {
    func hideEventList(_ hide: Bool) {
        if hide {
            eventCollectionView.isHidden = hide
            noEventLabel.isHidden = !hide
        } else {
            eventCollectionView.isHidden = !hide
            noEventLabel.isHidden = hide
        }
    }
}

