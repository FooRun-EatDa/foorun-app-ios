//
//  DetailView+CollectionViewExtension.swift
//  Foorun
//
//  Created by 김희진 on 2022/08/26.
//

import UIKit

extension DetailView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch collectionView {

        case hashTagCollectionView:
            return hashTagData.count

        case restaurantMenuCollectionView:
            return foodData.count

        default:
            return foodData.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch collectionView {

        case hashTagCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RestaurantHashTagCollectionViewCell.id, for: indexPath) as? RestaurantHashTagCollectionViewCell else {
                return UICollectionViewCell()
            }

            cell.hashTagModel = hashTagData[indexPath.row]
            return cell
            
        case restaurantMenuCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RestaurantMenuCollectionViewCell.id, for: indexPath) as? RestaurantMenuCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            cell.foodModel = foodData[indexPath.row]
            return cell
            
        default:
            return UICollectionViewCell()
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
            
        case hashTagCollectionView:
            return CGSize(width: 100, height: 30)
            
        case restaurantMenuCollectionView:
            return CGSize(width: 130, height: 208)
            
        default:
            return CGSize(width: 130, height: 208)
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 6
    }
}
