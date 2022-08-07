//
//  DetailView.swift
//  Foorun
//
//  Created by 김희진 on 2022/08/07.
//

import UIKit

class DetailView: UIView {
    lazy private var scrollView = UIScrollView()
    /// 맨 위에 메인 이미지에 들어가는 뷰 입니다.
    lazy private var headerImageView = UIImageView()
    /// 해시태그 컬렉션 뷰 입니다.
    lazy private var hashTagCollectionView = UICollectionView()
    
    
    init() {
        super.init(frame: .zero)
        
        setupScrollView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension DetailView {
    func setupScrollView() {
        addSubview(scrollView)
        
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        setupHeaderImageView()
        setupHashTagCollectionView()
    }
    
    func setupHeaderImageView() {
        scrollView.addSubview(headerImageView)
        
        headerImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func setupHashTagCollectionView() {
        scrollView.addSubview(hashTagCollectionView)
        
        hashTagCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
