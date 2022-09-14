//
//  MyPageMenuCell.swift
//  Foorun
//
//  Created by 김지훈 on 2022/09/14.
//

import UIKit
class MyPageMenuCell: UICollectionViewCell {
    
    // MARK: - IBOutlets
    let titleLabel = UILabel()
    let rightImageView = UIImageView()
    
    // MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTitleLabel()
        setupRightImageView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
    // MARK: - Methods
    func configureCell(with: String) {
        titleLabel.text = with
        print(with)
        rightImageView.image = UIImage(named: AssetSet.MyPage.chevronRight)
    }
    func setupTitleLabel() {
        contentView.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints {
            $0.centerY.leading.equalToSuperview()
        }
    }
    
    func setupRightImageView() {
        contentView.addSubview(rightImageView)
        
        rightImageView.snp.makeConstraints {
            $0.centerY.trailing.equalToSuperview()
        }
    }
}
