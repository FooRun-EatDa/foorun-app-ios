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
        let couponType = CouponType.checkCouponType(event: event)

        cell.setUI(event, couponType)

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedEvent = Event.dummyModel[indexPath.row]
        let couponType = CouponType.checkCouponType(event: selectedEvent)
        let viewController = EventDetailViewController()

        viewController.event = selectedEvent
        viewController.couponType = couponType

        navigationController?.pushViewController(viewController, animated: true)
    }
}
extension EventViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let minLineSpacing: CGFloat = 12
        let sideEdgeInset: CGFloat = 20
        let figmaHeight: CGFloat = 162

        let width: CGFloat = (UIScreen.main.bounds.width - minLineSpacing - (sideEdgeInset * 2)) / 2
        let aspectRatio = width / figmaHeight
        let height: CGFloat = CGFloat(225 * aspectRatio)

        return CGSize(width: width, height: height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {

        return CGFloat(11)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {

        return CGFloat(12)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {

        return UIEdgeInsets(top: 10, left: 20, bottom: 0, right: 20)
    }
}
