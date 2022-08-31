//
//  DetailView+TableViewExtension.swift
//  Foorun
//
//  Created by 김희진 on 2022/08/26.
//

import UIKit

extension DetailView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView( _ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
 
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RestaurantDetailTableViewCell.id, for: indexPath) as? RestaurantDetailTableViewCell else {
            return UITableViewCell()
        }
        
        let detailData = detailData
        switch indexPath.row {
            
        case 0:
            cell.cellTitleLabel.text = "전화번호"
            cell.cellDetailTitleLabel.text = detailData?.phoneNumber
                        
        case 1:
            cell.cellTitleLabel.text = "지역"
            cell.cellDetailTitleLabel.text = detailData?.district
            
        case 2:
            cell.cellTitleLabel.text = "가격대"
            guard let price = detailData?.price else {
                cell.cellDetailTitleLabel.text = "미입력"
                return UITableViewCell()
            }   
            var returnPrice = ""
            if price == 0 {
                returnPrice = "미입력"
            } else {
                returnPrice = "\(price)원대"
            }
            cell.cellDetailTitleLabel.text = returnPrice
            
        case 3:
            cell.cellTitleLabel.text = "상세 주소"
            guard let address = detailData?.address else {
                cell.cellDetailTitleLabel.text = "미입력"
                return UITableViewCell()
            }
            cell.cellDetailTitleLabel.text = "\(address)"

        default:
            return UITableViewCell()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
