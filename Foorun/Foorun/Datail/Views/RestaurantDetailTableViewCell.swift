//
//  RestaurantDetailTableViewCell.swift
//  Foorun
//
//  Created by 김희진 on 2022/07/10.
//
import Foundation
import UIKit
import SnapKit
import Then

class RestaurantDetailTableViewCell: UITableViewCell {

    static var id: String { NSStringFromClass(Self.self).components(separatedBy: ".").last ?? "" }
    var cellTitleLabel = UILabel().then {
          $0.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
          $0.textColor = .black
      }
      var cellDetailTitleLabel = UILabel().then {
          $0.font = UIFont.systemFont(ofSize: 15, weight: .regular)
          $0.textColor = .gray
      }

      override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {

          super.init(style: style, reuseIdentifier: reuseIdentifier)

          [cellTitleLabel, cellDetailTitleLabel].forEach{ contentView.addSubview($0) }
          cellTitleLabel.snp.makeConstraints {
              $0.top.bottom.equalToSuperview().inset(10)
              $0.leading.equalToSuperview().offset(24)
          }

          cellDetailTitleLabel.snp.makeConstraints {
              $0.top.bottom.equalToSuperview().inset(10)
              $0.trailing.equalToSuperview().offset(-24)
          }
      }

      required init?(coder: NSCoder) {
          fatalError("init(coder:) has not been implemented")
      }

      override func awakeFromNib() {
          super.awakeFromNib()
        }

        override func setSelected(_ selected: Bool, animated: Bool) {
            super.setSelected(selected, animated: animated)
            // Configure the view for the selected state
      }

  }
