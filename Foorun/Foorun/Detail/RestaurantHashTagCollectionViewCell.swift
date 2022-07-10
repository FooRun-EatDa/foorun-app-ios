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

    var model: String? { didSet { bind() } }
    
    lazy var hagTagLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        $0.textColor = .white
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubviews()
        configure()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }

    private func addSubviews() {
        addSubview(hagTagLabel)
    }

    private func configure() {
        
        self.backgroundColor = .systemYellow
        self.layer.cornerRadius = 15

        hagTagLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(13)
            make.top.bottom.equalToSuperview().inset(6)
        }
    }

    private func bind() {
        hagTagLabel.text = model
    }
}



