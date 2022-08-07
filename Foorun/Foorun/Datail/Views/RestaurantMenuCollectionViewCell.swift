//
//  RestaurantMenuCollectionViewCell.swift
//  Foorun
//
//  Created by 김희진 on 2022/07/10.
//
import Foundation
import UIKit

class RestaurantMenuCollectionViewCell: UICollectionViewCell {

    static var id: String { NSStringFromClass(Self.self).components(separatedBy: ".").last ?? "" }


    lazy var menuImage = UIImageView().then {
        $0.backgroundColor = .brown
          $0.layer.cornerRadius = 8
      }

      lazy var menuTitle = UILabel().then {
          $0.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
          $0.textColor = .black
      }

      lazy var menuDiscription = UILabel().then {
          $0.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
          $0.textColor = .gray
      }


      override init(frame: CGRect) {
          super.init(frame: frame)

          addSubviews()
          configure()
      }

      required init?(coder: NSCoder) {
          fatalError()
      }

      private func addSubviews() {
          [menuImage, menuTitle, menuDiscription].forEach { self.addSubview($0) }
      }

      private func configure() {
          menuImage.snp.makeConstraints { make in
              make.top.leading.trailing.equalToSuperview()
              make.width.height.equalTo(150)
          }

          menuTitle.snp.makeConstraints {
              $0.leading.trailing.equalToSuperview().inset(8)
              $0.top.equalTo(menuImage.snp.bottom).offset(10)
          }

          menuDiscription.snp.makeConstraints {
              $0.leading.trailing.equalToSuperview().inset(8)
              $0.top.equalTo(menuTitle.snp.bottom).offset(4)
              $0.bottom.equalToSuperview().offset(-10)
          }
      }
  }


