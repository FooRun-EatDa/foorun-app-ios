//
//  EventViewController.UICollectionView.swift
//  Foorun
//
//  Created by SeYeong on 2022/08/17.
//

import UIKit

extension EventViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return events.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: EventCollectionViewCell.identifier,
            for: indexPath
        ) as? EventCollectionViewCell else { return UICollectionViewCell() }

        let event = events[indexPath.row]
        CouponType.checkCouponType(event: event) { couponType in
            cell.configure(with: event, couponType)
        }

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedEvent = Event.dummyModel[indexPath.row]
        let viewController = EventDetailViewController()
        CouponType.checkCouponType(event: selectedEvent) { [weak self] couponType in
            viewController.event = selectedEvent
            viewController.couponType = .available
            viewController.hidesBottomBarWhenPushed = true
            self?.navigationController?.pushViewController(viewController, animated: true)
        }
    }
}
extension EventViewController: UICollectionViewDelegateFlowLayout {
    var minInterItemSpacing: CGFloat { return 11 }
    var minLineSpacing: CGFloat { return 12 }
    var sideEdgeInset: CGFloat { return 20 }
    var figmaHeight: CGFloat { return 162 }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = (UIScreen.main.bounds.width - minLineSpacing - (sideEdgeInset * 2)) / 2
        let aspectRatio = width / figmaHeight
        let height: CGFloat = CGFloat(225 * aspectRatio)

        return CGSize(width: width, height: height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return minInterItemSpacing
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return minLineSpacing
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: sideEdgeInset, bottom: 0, right: sideEdgeInset)
    }
}
