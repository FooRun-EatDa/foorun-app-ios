//
//  MyPageMainCell.swift
//  Foorun
//
//  Created by 김지훈 on 2022/09/14.
//

import UIKit

final class MyPageProfileCell: UICollectionViewCell {
    
    // MARK: - IBOutlets
    let profileImageView = UIImageView()
    let nameLabel = UILabel()
    let certificationButton = UIButton()
    let logoImageView = UIImageView()

    
    // MARK: - Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupContentView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    func configureCell(with item: MyPageViewModel) {
        profileImageView.image = UIImage(named: item.profileImageName)
        
        nameLabel.text = item.name == "" ? "인증이 필요해요 ‼️ " : "\(item.name) 님"
        
        logoImageView.image = UIImage(named: item.logoImageName)

        certificationButton.setTitle( item.name == "" ? "인증 하기" : "인증완료", for: .normal)
        certificationButton.isEnabled = item.name == ""
    }
}
extension MyPageProfileCell {
    private func setupContentView() {
        contentView.backgroundColor = UIColor(red: 251/255, green: 183/255, blue: 52/255, alpha: 1)
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 19

        setupProfileImageView()
        setupNameLabel()
        setupCertificationButton()
        setupLogoImageView()
    }
    
    private func setupProfileImageView() {
        contentView.addSubview(profileImageView)
        profileImageView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(20)
            $0.leading.equalToSuperview().offset(13)
            $0.width.equalTo(profileImageView.snp.height)
        }
    }
    
    private func setupNameLabel() {
        contentView.addSubview(nameLabel)
        
        nameLabel.font = UIFont.boldSystemFont(ofSize: 21)
        nameLabel.textColor = .white
        
        nameLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview().offset(-9.5)
            $0.leading.equalTo(profileImageView.snp.trailing).offset(15)
        }
    }
    
    private func setupCertificationButton() {
        contentView.addSubview(certificationButton)

        certificationButton.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        
        certificationButton.snp.makeConstraints {
            $0.centerY.equalToSuperview().offset(14.5)
            $0.leading.equalTo(nameLabel)
        }
    }
    
    private func setupLogoImageView() {
        contentView.addSubview(logoImageView)
        
        logoImageView.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.trailing.equalToSuperview().offset(10.73)
        }
    }
}
