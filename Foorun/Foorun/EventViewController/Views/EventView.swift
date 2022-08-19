//
//  EventView.swift
//  Foorun
//
//  Created by SeYeong on 2022/08/17.
//

import UIKit
import SnapKit

class EventView: UIView {

    let emptyLabel = UILabel()
    let collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout()
    )

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupEmptyLabel()
        setupCollectionView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension EventView {
    func setupEmptyLabel() {
        addSubview(emptyLabel)

        emptyLabel.text = "현재 진행중인 이벤트가 없어요..😢"

        emptyLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(-50)
        }
    }

    func setupCollectionView() {
        addSubview(collectionView)

        collectionView.register(
            EventCollectionViewCell.self,
            forCellWithReuseIdentifier: EventCollectionViewCell.identifier)

        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
