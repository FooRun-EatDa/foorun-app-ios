//
//  KUEventDeatilViewController.swift
//  Foorun
//
//  Created by Hamlit Jason on 2022/08/16.
//

import UIKit

class KUEventDeatilViewController: UIViewController {
    
    // Propertiee
    var eventDetail: Event.Detail?
    
    // -
    var eventDetailView = KUEventDeatilView()
    
//    init(item: Event.Detail) {
//        self.eventDetail = item
//
//        super.init(nibName: nil, bundle: nil)
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupEventDetailView()
        
//        eventDetailView.setUI()
    }
    
    func setupEventDetailView() {
        view.addSubview(eventDetailView)
        
        eventDetailView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

class KUEventDeatilView: UIView {
    
    let scrollView = UIScrollView()
    
    var bannerImageView = UIImageView()
    var themeLabel = UILabel()
    var restaurantTitleLabel = UILabel()
    
    var dateLabel = UILabel()
    var descriptionLabel = UILabel()
    
    var warningLabel = UILabel()
    var warningDescriptionLabel = UILabel()
    
    // NOTE: -
    var buttonContainerView = UIView()
    var couponButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setupButtonContainerView()
        setupScrollView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUI(_ item: String) { }
}

extension KUEventDeatilView {
    func setupButtonContainerView() {
        addSubview(buttonContainerView)
        
        buttonContainerView.snp.makeConstraints {
            $0.bottom.leading.trailing.equalToSuperview()
            $0.height.equalTo(105)
        }
        
        buttonContainerView.addSubview(couponButton)
        couponButton.setTitle("👍 쿠폰 사용하기", for: .normal)
        
        couponButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(15)
            $0.leading.trailing.equalToSuperview().inset(35)
            $0.height.equalTo(50)
        }
        
        
    }
    
    func setupScrollView() {
        addSubview(scrollView)
        
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func setupBannerImageView() {
        scrollView.addSubview(bannerImageView)
        
        
    }
}

