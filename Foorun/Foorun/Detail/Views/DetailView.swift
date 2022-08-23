//
//  DetailView.swift
//  Foorun
//
//  Created by 김희진 on 2022/08/07.
//

import UIKit
import Then
import RxSwift


class DetailView: UIView {
    
    let disposeBag = DisposeBag()

    var data = BehaviorSubject<RestaurantDetail?>(value: nil)
    var foodData: [Food] = []
    var hashTagData: [String] = []
    var detailData: RestaurantDetailClientModel?

    private lazy var scrollView = UIScrollView()
    
    var headerContainerView = UIView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    var imageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.clipsToBounds = true
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
    func bindView() {
        data.subscribe( onNext: { data in
            DispatchQueue.global().async {
                if let foodsData = data?.foods {
                    if !foodsData.isEmpty {
                        let _url = URL(string: foodsData[0].files[0].url ?? "" )
                        if let url = _url, let data = try? Data(contentsOf: url) {
                            DispatchQueue.main.async {
                                self.imageView.image = UIImage(data: data)
                            }
                        }

                    }
                }
            }
            
            self.restaurantTitleLabel.text = data?.name
            self.restaurantSubTitleLabel.text = data?.explanation
            self.foodData = data?.foods ?? []
            
            self.detailData = RestaurantDetailClientModel(name: data?.name, imgUrl: data?.imgUrl, content: data?.content, address: data?.address, phoneNumber: data?.phoneNumber, operationTime: data?.operationTime, district: data?.district, liked: data?.liked)

            guard let categories = data?.categories else {
                return
            }
            if categories.count > 0 {
                self.hashTagData = categories
            } else {
                self.hashTagData = [(data?.district ?? "경희대") + " 대표 맛집"]
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
                
        contentView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(self)
            make.top.equalTo(scrollView.snp.top).offset(220)
            make.bottom.equalTo(scrollView.snp.bottom)
        }
        let headerContainerViewBottom : NSLayoutConstraint!
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
            $0.height.equalTo(38 * 5)
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

extension DetailView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case hashTagCollectionView:
            return hashTagData.count
        case restaurantMenuCollectionView:
            return foodData.count
        default:
            return foodData.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {

        case hashTagCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RestaurantHashTagCollectionViewCell.id, for: indexPath) as? RestaurantHashTagCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.hashTagModel = hashTagData[indexPath.row]
            
            return cell
            
        case restaurantMenuCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RestaurantMenuCollectionViewCell.id, for: indexPath) as? RestaurantMenuCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.foodModel = foodData[indexPath.row]
            
            return cell
            
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case hashTagCollectionView:
            return CGSize(width: 100, height: 30)
            
        case restaurantMenuCollectionView:
            return CGSize(width: 130, height: 208)
            
        default:
            return CGSize(width: 130, height: 208)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 6
    }
}


extension DetailView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView( _ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RestaurantDetailTableViewCell.id, for: indexPath) as? RestaurantDetailTableViewCell else {
            return UITableViewCell()
        }
        
        
        let detailData = detailData
        switch indexPath.row {
        case 0:
            cell.cellTitleLabel.text = "종류"
            cell.cellDetailTitleLabel.text = detailData?.name
            
        case 1:
            cell.cellTitleLabel.text = "전화번호"
            cell.cellDetailTitleLabel.text = detailData?.phoneNumber
                        
        case 2:
            cell.cellTitleLabel.text = "지역"
            cell.cellDetailTitleLabel.text = detailData?.district
            
        case 3:
            cell.cellTitleLabel.text = "가격대"
            cell.cellDetailTitleLabel.text = "\(detailData?.price ?? 10000)원대"
            
        case 4:
            cell.cellTitleLabel.text = "영업시간"
            cell.cellDetailTitleLabel.text = detailData?.operationTime ?? "미제공"
            
        default:
            return UITableViewCell()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
