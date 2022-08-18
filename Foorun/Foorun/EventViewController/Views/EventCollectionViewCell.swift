//
//  EventCollectionViewCell.swift
//  Foorun
//
//  Created by MacPro on 2022/08/17.
//

import UIKit
import SnapKit
import Kingfisher

class EventCollectionViewCell: UICollectionViewCell {
    // MARK: - Properties
    static let identifier = String(describing: self)
    let sideEdgeInset: CGFloat = 20
    let minLineSpacing: CGFloat = 12
    lazy var cellWidth = (UIScreen.main.bounds.width - (2 * sideEdgeInset) - minLineSpacing) / 2
    lazy var aspectRatio = cellWidth / CGFloat(162)


    // MARK: - IBOutlets
    var imageView = UIImageView()
    var eventTitleLabel = UILabel()
    var restaurantTitleLabel = UILabel()
    var dateLabel = UILabel()
    var stampImageView = UIImageView()
    var overlayView = UIView()

    // MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: .zero)

        setupCellLayer()
        setupImageView()
        setupEventTitleLabel()
        setupRestaurantTitleLabel()
        setupDateLabel()
        setupOverlayView()
        setupStampImageView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setUI(_ item: Event, _ type: CouponType) {
        let imageURL = URL(string: item.imageURL ?? "")
        imageView.kf.setImage(with: imageURL)
        eventTitleLabel.text = item.eventName
        restaurantTitleLabel.text = item.restaurantName
        dateLabel.text = item.date
        overlayView.isHidden = type.overlayIsHidden()
        stampImageView.image = type.stampImage()
    }

    private func setupCellLayer() {
        contentView.layer.cornerRadius = 12 * aspectRatio
        contentView.backgroundColor = .white
        contentView.clipsToBounds = true

        layer.shadowOffset = .zero
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowRadius = 5
        layer.cornerRadius = 12 * aspectRatio
        layer.shadowOpacity = 0.15
    }

    private func setupImageView() {
        contentView.addSubview(imageView)

        imageView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(152 * aspectRatio)
        }
    }

    private func setupEventTitleLabel() {
        contentView.addSubview(eventTitleLabel)

        eventTitleLabel.font = UIFont.boldSystemFont(ofSize: 16)

        eventTitleLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(7 * aspectRatio)
            $0.leading.equalToSuperview().inset(11)
            $0.height.equalTo(23 * aspectRatio)
        }
    }

    private func setupRestaurantTitleLabel() {
        contentView.addSubview(restaurantTitleLabel)

        restaurantTitleLabel.font = .systemFont(ofSize: 13)

        restaurantTitleLabel.snp.makeConstraints {
            $0.top.equalTo(eventTitleLabel.snp.bottom).inset(1 * aspectRatio)
            $0.leading.equalTo(eventTitleLabel.snp.leading).inset(1)
            $0.height.equalTo(16 * aspectRatio)
        }
    }

    private func setupDateLabel() {
        contentView.addSubview(dateLabel)

        dateLabel.font = .systemFont(ofSize: 12, weight: .regular)
        dateLabel.tintColor = .lightGray

        dateLabel.snp.makeConstraints {
            $0.top.equalTo(restaurantTitleLabel.snp.bottom).offset(2 * aspectRatio)
            $0.leading.equalToSuperview().inset(12)
            $0.bottom.equalToSuperview().inset(10 * aspectRatio)
        }
    }

    private func setupStampImageView() {
        contentView.addSubview(stampImageView)

        stampImageView.snp.makeConstraints {
            $0.top.trailing.equalToSuperview().inset(10)
            $0.width.equalToSuperview().multipliedBy(0.35)
            $0.height.equalTo(stampImageView.snp.width)
        }
    }

    private func setupOverlayView() {
        contentView.addSubview(overlayView)

        overlayView.backgroundColor = .black.withAlphaComponent(0.5)
        overlayView.isHidden = true

        overlayView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
