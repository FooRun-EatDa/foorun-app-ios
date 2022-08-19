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
    
    var foodModel: Food? {
        didSet {
            bind()
        }
    }

    lazy var menuImage = UIImageView().then {
        $0.layer.cornerRadius = 8
        $0.clipsToBounds = true
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
        menuImage.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.width.height.equalTo(130)
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
    
    func bind() {
        DispatchQueue.global().async {
            let _url = URL(string: self.foodModel?.files[0].url ?? "")
            
            guard let url = _url, let data = try? Data(contentsOf: url) else {
                self.menuImage.backgroundColor = .lightGray
                self.menuTitle.text = self.foodModel?.name
                self.menuDiscription.text = self.foodModel?.content
                return
            }
            
            DispatchQueue.main.async {
                self.menuImage.image = UIImage(data: data)
            }
        }
        menuTitle.text = foodModel?.name
        menuDiscription.text = foodModel?.content
    }
}


