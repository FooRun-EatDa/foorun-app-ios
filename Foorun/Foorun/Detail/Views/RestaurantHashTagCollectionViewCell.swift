//
//  RestaurantHashTagCollectionViewCell.swift
//  Foorun
//
//  Created by 김희진 on 2022/07/10.
//
import Foundation
import UIKit

class RestaurantHashTagCollectionViewCell: UICollectionViewCell {

    static var id: String { NSStringFromClass(Self.self).components(separatedBy: ".").last ?? "" }

    var hashTagModel: String? {
        didSet {
            bind()
        }
    }
    
    
    lazy var hagTagLabel = UILabel().then {
           $0.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
           $0.textColor = .white
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
           addSubview(hagTagLabel)
       }

       private func configure() {
           self.backgroundColor = .systemYellow
           self.layer.cornerRadius = 15

           hagTagLabel.snp.makeConstraints {
               $0.leading.trailing.equalToSuperview().inset(13)
               $0.top.bottom.equalToSuperview().inset(6)
           }
       }

       private func bind() {
           hagTagLabel.text = hashTagModel
       }
   }


//class HashTagCollectionViewCell: UICollectionViewCell {
//    let identifier = String(describing: self)
//
//    lazy var containerView = UIView()
//    lazy var tagLabel = UILabel()
//
//    override init(frame: CGRect) {
//        super.init(frame: .zero)
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    func setUI(_ data: ) {
//        tagLabel.text = data.id
//    }
//}
//
//extension HashTagCollectionViewCell {
//    var padding: CGFloat {
//        get { return 10.0 }
//    }
//
//    func setupContainerView() {
//        contentView.addSubview(containerView)
//
//        containerView.backgroundColor = .systemYellow
//        containerView.snp.makeConstraints {
//            $0.edges.equalToSuperview()
//        }
//
//        setupTagLabel()
//    }
//
//    func setupTagLabel() {
//        containerView.addSubview(tagLabel)
//
//        tagLabel.snp.makeConstraints {
//            $0.top.bottom.equalToSuperview().inset(padding)
//            $0.leading.trailing.equalToSuperview().inset(padding)
//        }
//    }
//}
