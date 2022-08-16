import UIKit
import SnapKit
import FoorunKey

protocol EventListViewDelegate: AnyObject {
    func eventDidSelected(info: Event.Detail)
    func refreshEvent()
    func hideEventList(_ isHidden: Bool)
}

class EventListView: UIView {
//     MARK: - Properties
    var eventDetails: [Event.Detail] = [] {
        didSet {
            eventCollectionView.reloadData()
        }
    }
    weak var delegate: EventListViewDelegate?

    //MARK: - SubComponents
    private lazy var eventCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.register(EventCell.self, forCellWithReuseIdentifier: EventCell.identifier)
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
        let cellWidth = (UIScreen.main.bounds.width - (2 * sideEdgeInset) - minLineSpacing) / 2 - 1
        let ratio = cellWidth / CGFloat(162.34)
        let cellHeight = CGFloat(225.47 * ratio)

        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
        layout.sectionInset = UIEdgeInsets(top: 0, left: sideEdgeInset, bottom: 0, right: sideEdgeInset)
        layout.minimumLineSpacing = minLineSpacing
        layout.minimumInteritemSpacing = minItemSpacing

        return layout
    }()

    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)

        return refreshControl
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Layout
extension EventListView {
    private func layout() {
        backgroundColor = UIColor(named: "EventVCBgColor")
        addSubview(eventCollectionView)

        eventCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
        }
    }

    @objc
    private func refresh() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.delegate?.refreshEvent()
        }
    }

    func endRefreshing() {
        self.refreshControl.endRefreshing()
        self.refreshControl.isHidden = true
    }

    func reloadData() {
        self.eventCollectionView.reloadData()
    }
}

//MARK: - CollectionView Datasource
extension EventListView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let numberOfEventInfos = eventDetails.count

        if numberOfEventInfos == 0 {
            delegate?.hideEventList(true)
        } else {
            delegate?.hideEventList(false)
        }

        return numberOfEventInfos
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EventCell.identifier, for: indexPath) as? EventCell else { return UICollectionViewCell() }
        let eventDetail = eventDetails[indexPath.row]
        cell.configure(detail: eventDetail)

        return cell
    }
}

// MARK: - CollectionView Delegate
extension EventListView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedEvent = eventDetails[indexPath.row]
        delegate?.eventDidSelected(info: selectedEvent)
    }
}
