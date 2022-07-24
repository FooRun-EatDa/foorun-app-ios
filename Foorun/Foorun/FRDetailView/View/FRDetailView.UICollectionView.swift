//
//  FRDetail.UICollectionView.swift
//  Foorun
//
//  Created by Hamlit Jason on 2022/07/24.
//

import UIKit
import SnapKit

class HashTagCollectionViewCell: UICollectionViewCell {
    let identifier = String(describing: self)

    lazy var containerView = UIView()
    lazy var tagLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUI(_ data: ) {
        tagLabel.text = data.id
    }
}

extension HashTagCollectionViewCell {
    var padding: CGFloat {
        get { return 10.0 }
    }
    
    func setupContainerView() {
        contentView.addSubview(containerView)
        
        containerView.backgroundColor = .systemYellow
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        setupTagLabel()
    }
    
    func setupTagLabel() {
        containerView.addSubview(tagLabel)
        
        tagLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(padding)
            $0.leading.trailing.equalToSuperview().inset(padding)
        }
    }
}
