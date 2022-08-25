//
//  DetailView.swift
//  Foorun
//
//  Created by 김희진 on 2022/08/07.
//

import UIKit
import Then
import RxSwift
import RxCocoa
import Kingfisher

public enum RestarauntDesc: String {
    case phonenumber = "전화번호"
    case district = "지역"
    case price = "가격"
    case workTime = "운영시간"
}


class DetailView: UIView {
    
    let disposeBag = DisposeBag()

    var data = BehaviorRelay<RestaurantDetail?>(value: nil)
    
    var foodData: [Food] = []
    var hashTagData: [String] = []
    var detailData: RestaurantDetailClientModel?
    
    var isBookMarkSelected: Bool {
        didSet {
            if isBookMarkSelected {
                heartButton.setImage(UIImage(named: "Detail/heartFilled"), for: .normal)
            } else {
                heartButton.setImage(UIImage(named: "Detail/heartEmpty"), for: .normal)
            }
        }
    }

    private lazy var scrollView = UIScrollView()
    
    var headerContainerView = UIView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    var imageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.clipsToBounds = true
    }
    
    var heartButton = UIButton().then {
        $0.setImage(UIImage(named: "Detail/heartEmpty"), for: .normal)
        $0.isSelected = false
        $0.isUserInteractionEnabled = true
    }
    
    var contentView = UIView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    var restaurantDiscripionView = UIView().then {
        $0.backgroundColor = .white
    }
    
    var restaurantTitleView = UIView().then {
        $0.backgroundColor = .white
    }
    
    var restaurantTitleLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        $0.textColor = .black
    }
    
    var restaurantSubTitleLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        $0.textColor = .gray
    }
    
    lazy var hashTagCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 10
        flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.showsHorizontalScrollIndicator = false
        view.delegate = self
        view.dataSource = self
        view.register(RestaurantHashTagCollectionViewCell.self, forCellWithReuseIdentifier: RestaurantHashTagCollectionViewCell.id)
        return view
    }()
    
    lazy var restaurantDetailTableView: UITableView = {
        let view = UITableView()
        view.delegate = self
        view.dataSource = self
        view.separatorStyle = .none
        view.allowsSelection = false
        view.isScrollEnabled = false
        view.register(RestaurantDetailTableViewCell.self, forCellReuseIdentifier: RestaurantDetailTableViewCell.id)
        return view
    }()
    lazy var restaurantMenuCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        let view = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.showsHorizontalScrollIndicator = false
        view.delegate = self
        view.dataSource = self
        view.register(RestaurantMenuCollectionViewCell.self, forCellWithReuseIdentifier: RestaurantMenuCollectionViewCell.id)
        return view
    }()
    
    init() {
        self.isBookMarkSelected = false
        super.init(frame: .zero)
        
        setupScrollView()
        setupInnerView()
        bindView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension DetailView {
    
    // MARK: 여기 코드가 너무 더러움,,, 수정필요..
    func bindView() {
        data.subscribe(onNext: { data in
            DispatchQueue.global().async {
                if let foodsData = data?.foods {
                    if !foodsData.isEmpty {
                        guard let imageURL = foodsData[0].files.first?.url else {
                            return
                        }
                        DispatchQueue.main.async {
                            self.imageView.kf.setImage(with: URL(string: imageURL), placeholder: UIImage(named: "defaultImage"))
                        }
                    }
                }
            }
            
            self.restaurantTitleLabel.text = data?.name
            self.restaurantSubTitleLabel.text = data?.explanation
            self.foodData = data?.foods ?? []
            
            self.detailData = RestaurantDetailClientModel(name: data?.name, imgUrl: data?.imgUrl, content: data?.content, address: data?.address, phoneNumber: data?.phoneNumber, operationTime: data?.operationTime, district: data?.district, liked: data?.liked)

            guard let hashTags = data?.hashTags else {
                return
            }
            if hashTags.count > 0 {
                self.hashTagData = hashTags
            } else {
                self.hashTagData = [(data?.district ?? "경희대") + " 대표 맛집"]
            }
            
            let bookData = UserDefaultManager.shared.bookmarks
            if bookData.contains(where: { ($0 as RestaurantDetail).id == data?.id }) {
                self.isBookMarkSelected = true
            } else {
                self.isBookMarkSelected = false
            }
            
            self.restaurantDetailTableView.reloadData()
            self.hashTagCollectionView.reloadData()
            self.restaurantMenuCollectionView.reloadData()

        }).disposed(by: disposeBag)
    }
}


extension DetailView {
    
    func setupScrollView() {
        
        addSubview(scrollView)
        scrollView.backgroundColor = .white
        scrollView.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        [headerContainerView, contentView].forEach { scrollView.addSubview($0) }

        headerContainerView.addSubview(imageView)
        
        contentView.addSubview(restaurantDiscripionView)
        [restaurantTitleView, restaurantDetailTableView, restaurantMenuCollectionView].forEach { restaurantDiscripionView.addSubview($0) }
                
        contentView.snp.makeConstraints {
            $0.leading.trailing.equalTo(self)
            $0.top.equalTo(scrollView.snp.top).offset(220)
            $0.bottom.equalTo(scrollView.snp.bottom)
        }
        
        let headerContainerViewBottom: NSLayoutConstraint!
        NSLayoutConstraint.activate([
            headerContainerView.topAnchor.constraint(equalTo: self.topAnchor),
            headerContainerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            headerContainerView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
        headerContainerViewBottom = headerContainerView.bottomAnchor.constraint(equalTo: contentView.topAnchor, constant: 0)
        headerContainerViewBottom.priority = UILayoutPriority(rawValue: 900)
        headerContainerViewBottom.isActive = true
        
        
        let imageViewTopConstraint: NSLayoutConstraint!
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: headerContainerView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: headerContainerView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: headerContainerView.bottomAnchor)
        ])
        
        imageViewTopConstraint = imageView.topAnchor.constraint(equalTo: self.topAnchor)
        imageViewTopConstraint.priority = UILayoutPriority(rawValue: 900)
        imageViewTopConstraint.isActive = true
        
        contentView.addSubview(heartButton)
        heartButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(20)
            $0.top.equalToSuperview().offset(20)
        }
    }
    
    func setupInnerView() {
        restaurantDiscripionView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
        
        restaurantTitleView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }
        
        restaurantTitleView.addSubview(restaurantTitleLabel)
        restaurantTitleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.top.equalToSuperview().offset(16)
        }
        
        restaurantTitleView.addSubview(restaurantSubTitleLabel)
        restaurantSubTitleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.top.equalTo(restaurantTitleLabel.snp.bottom).offset(8)
        }
        
        restaurantTitleView.addSubview(hashTagCollectionView)
        hashTagCollectionView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.trailing.equalToSuperview()
            $0.top.equalTo(restaurantSubTitleLabel.snp.bottom).offset(12)
            $0.height.equalTo(30)
            $0.bottom.equalToSuperview().offset(-16)
        }
        
        restaurantDetailTableView.snp.makeConstraints {
            $0.top.equalTo(restaurantTitleView.snp.bottom)
            $0.height.equalTo(38 * 4)
            $0.leading.trailing.equalToSuperview()
        }
        
        restaurantMenuCollectionView.snp.makeConstraints {
            $0.top.equalTo(restaurantDetailTableView.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(10)
            $0.height.equalTo(208)
            $0.bottom.equalToSuperview()
        }
    }
}
