//
//  RestaurantMenuCollectionViewCell.swift
//  Foorun
//
//  Created by 김희진 on 2022/07/10.
//
import Foundation
import UIKit

class RestaurantMenuCollectionViewCell: UICollectionViewCell {

    static var id: String { self.identifier }

    var foodModel: Food? {
        didSet {
            bind()
        }
    }

    var menuImage = UIImageView().then {
        $0.layer.cornerRadius = 8
        $0.clipsToBounds = true
        $0.image = UIImage(named: AssetSet.ETC.Food.empty)
    }

    var menuTitle = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        $0.textColor = .black
    }
    
    var menuPrice = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        $0.textColor = .systemYellow
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
        [menuImage, menuTitle, menuPrice].forEach { self.addSubview($0) }
    }

    private func configure() {
        menuImage.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.width.height.equalTo(130)
        }

        menuTitle.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(8)
            $0.top.equalTo(menuImage.snp.bottom).offset(10)
        }
        
        menuPrice.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(8)
            $0.top.equalTo(menuTitle.snp.bottom).offset(4)
            $0.bottom.equalToSuperview().offset(-10)
        }
    }
    
    func bind() {
        guard let imageURL = self.foodModel?.files.first?.url else {
            self.menuImage.image = UIImage(named: AssetSet.ETC.Food.empty)
            self.menuTitle.text = self.foodModel?.name
            self.menuPrice.text = String(self.foodModel?.price ?? 0) + "원"
            return
        }
        self.menuImage.kf.setImage(with: URL(string: imageURL), placeholder: UIImage(named: AssetSet.ETC.Food.empty))
        self.menuTitle.text = self.foodModel?.name
        self.menuPrice.text = String(self.foodModel?.price ?? 0) + "원"
    }
}
