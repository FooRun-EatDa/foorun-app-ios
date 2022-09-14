//
//  MyPageMainCell.swift
//  Foorun
//
//  Created by 김지훈 on 2022/09/14.
//

import UIKit
protocol MyPageMainCellDelegate {
    func goToCertificationView()
}
class MyPageMainCell: UICollectionViewCell {
    // MARK: - IBOutlets
    let userImageView = UIImageView()
    let nameLabel = UILabel()
    let certificationButton = UIButton()
    let logoImageView = UIImageView()
    var delegate: MyPageMainCellDelegate?
    // MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupContentView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    func configureCell(with: MyPageViewModel) {
        userImageView.image = UIImage(named: with.userImgUrl)
        nameLabel.text = with.name == "" ? "인증이 필요해요 ‼️ " : "\(with.name) 님"
        nameLabel.font = UIFont.boldSystemFont(ofSize: 21)
        logoImageView.image = UIImage(named: with.logoImgUrl)
        // TODO: - 화면 전환 및 로직
        certificationButton.setTitle( with.name == "" ? "인증 하기" : "인증완료", for: .normal)
        certificationButton.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        certificationButton.isEnabled = with.name == ""
    }
    
    func setupContentView() {
        contentView.backgroundColor = UIColor(red: 251/255, green: 183/255, blue: 52/255, alpha: 1)
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 19
        
        setupUserImageView()
        setupNameLabel()
        setupCertificationButton()
        setupLogoImageView()
    }
    
    func setupUserImageView() {
        contentView.addSubview(userImageView)
        userImageView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(20)
            $0.leading.equalToSuperview().offset(13)
            $0.width.equalTo(userImageView.snp.height)
        }
    }
    
    func setupNameLabel() {
        contentView.addSubview(nameLabel)
        
        nameLabel.textColor = .white
        nameLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview().offset(-9.5)
            $0.leading.equalTo(userImageView.snp.trailing).offset(15)
        }
    }
    
    func setupCertificationButton() {
        contentView.addSubview(certificationButton)
        
        certificationButton.addTarget(self, action: #selector(touchUpCertificationButton), for: .touchUpInside)
        certificationButton.snp.makeConstraints {
            $0.centerY.equalToSuperview().offset(14.5)
            $0.leading.equalTo(nameLabel)
        }
    }
    @objc
    func touchUpCertificationButton() {
        delegate?.goToCertificationView()
    }
    func setupLogoImageView() {
        contentView.addSubview(logoImageView)
        logoImageView.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.trailing.equalToSuperview().offset(10.73)
        }
    }
    
}
