//
//  MyPageMenuCell.swift
//  Foorun
//
//  Created by 김지훈 on 2022/09/14.
//

import UIKit

final class MyPageMenuCell: UICollectionViewCell {
    
    // MARK: - IBOutlets
    let titleLabel = UILabel()
    let accessoryDisclosureIndicator = UIImageView()
    
    // MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupTitleLabel()
        setupRightImageView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
    func configureCell(with item: String) {
        titleLabel.text = item
    }

}

extension MyPageMenuCell {

    
    private func setupTitleLabel() {
        contentView.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints {
            $0.centerY.leading.equalToSuperview()
        }
    }
    
    private func setupRightImageView() {
        contentView.addSubview(accessoryDisclosureIndicator)
        
        accessoryDisclosureIndicator.image = UIImage(named: AssetSet.MyPage.chevronRight)
        
        accessoryDisclosureIndicator.snp.makeConstraints {
            $0.centerY.trailing.equalToSuperview()
        }
    }
}
