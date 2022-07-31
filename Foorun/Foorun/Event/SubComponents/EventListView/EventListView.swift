import UIKit
import SnapKit

class EventListView: UIView {
    //MARK: - SubComponents
    private lazy var eventCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.register(EventCell.self, forCellWithReuseIdentifier: EventCell.identifier)
        collectionView.backgroundColor = UIColor(named: "EventVCBgColor")
        collectionView.isScrollEnabled = true
        collectionView.alwaysBounceVertical = false
        collectionView.dataSource = self

        return collectionView
    }()

    private lazy var flowLayout: UICollectionViewLayout = {
        let sideEdgeInset = CGFloat(19.46)
        let minLineSpacing = CGFloat(11.36)
        let minItemSpacing = CGFloat(11.73)
        let aspectRatio = 0.72
        let cellWidth = (UIScreen.main.bounds.width - (2 * sideEdgeInset) - minLineSpacing) / 2 - 1
        let cellHeight = cellWidth / 0.72

        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
        layout.sectionInset = UIEdgeInsets(top: 0, left: sideEdgeInset, bottom: 0, right: sideEdgeInset)
        layout.minimumLineSpacing = minLineSpacing
        layout.minimumInteritemSpacing = minItemSpacing

        return layout
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
        addSubview(eventCollectionView)

        eventCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
        }
    }
}

//MARK: - CollectionView Datasource
extension EventListView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return 12
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EventCell.identifier, for: indexPath) as? EventCell else { return UICollectionViewCell() }

        return cell
    }
}
