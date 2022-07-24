//
//  DetailViewController.swift
//  Foorun
//
//  Created by 김희진 on 2022/07/10.
//

import UIKit
import SnapKit
import Then

class DetailViewController: UIViewController {
    
    lazy var scrollView = UIScrollView().then {
        $0.backgroundColor = .white
        $0.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height)
    }
        
    var headerContainerView = UIView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
        
    var imageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.clipsToBounds = true
        $0.backgroundColor = .red
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
        $0.text = "맘스터치"
    }
        
    var restaurantSubTitleLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        $0.textColor = .gray
        $0.text = "맥도날드보다 롯데리아보다 맛있는 맘스터치!"
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
        flowLayout.minimumLineSpacing = 10
        flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize

        let view = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.showsHorizontalScrollIndicator = false
        view.delegate = self
        view.dataSource = self
        view.register(RestaurantMenuCollectionViewCell.self, forCellWithReuseIdentifier: RestaurantMenuCollectionViewCell.id)
        return view
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        addGesture()
    }
    
    
    override func viewWillLayoutSubviews() {

        view.addSubview(scrollView)

        [headerContainerView, contentView].forEach { scrollView.addSubview($0) }
        headerContainerView.addSubview(imageView)
        contentView.addSubview(restaurantDiscripionView)
        
        [restaurantTitleView, restaurantDetailTableView, restaurantMenuCollectionView].forEach { restaurantDiscripionView.addSubview($0) }
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(view)
            make.top.equalTo(scrollView.snp.top).offset(220)
            make.bottom.equalTo(scrollView.snp.bottom)
        }
        
        let headerContainerViewBottom : NSLayoutConstraint!
        NSLayoutConstraint.activate([
            headerContainerView.topAnchor.constraint(equalTo: view.topAnchor),
            headerContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
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

        imageViewTopConstraint = imageView.topAnchor.constraint(equalTo: self.view.topAnchor)
        imageViewTopConstraint.priority = UILayoutPriority(rawValue: 900)
        imageViewTopConstraint.isActive = true
        
        restaurantDiscripionView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
        
        restaurantTitleView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
        }
        
        restaurantTitleView.addSubview(restaurantTitleLabel)
        restaurantTitleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(16)
        }

        restaurantTitleView.addSubview(restaurantSubTitleLabel)
        restaurantSubTitleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.top.equalTo(restaurantTitleLabel.snp.bottom).offset(8)
        }

        restaurantTitleView.addSubview(hashTagCollectionView)
        hashTagCollectionView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(20)
            make.trailing.equalToSuperview()
            make.top.equalTo(restaurantSubTitleLabel.snp.bottom).offset(12)
            make.height.equalTo(30)
            make.bottom.equalToSuperview().offset(-16)
        }
        
        restaurantDetailTableView.snp.makeConstraints { make in
            make.top.equalTo(restaurantTitleView.snp.bottom)
            make.height.equalTo(38 * 5)
            make.leading.trailing.equalToSuperview()
        }
   
        restaurantMenuCollectionView.snp.makeConstraints { make in
            make.top.equalTo(restaurantDetailTableView.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(10)
            make.height.equalTo(208)
            make.bottom.equalToSuperview()
        }
    }
        
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.title = ""
    }
    
    func addGesture() {
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture(_:)))
        swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
        headerContainerView.addGestureRecognizer(swipeLeft)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture(_:)))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
        headerContainerView.addGestureRecognizer(swipeRight)
    }
    
    @objc func respondToSwipeGesture(_ gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer{
            switch swipeGesture.direction {
            case UISwipeGestureRecognizer.Direction.left :
                print("page Changed1")
                imageView.backgroundColor = .blue

            case UISwipeGestureRecognizer.Direction.right :
                print("page Changed2")
                imageView.backgroundColor = .black

            default:
                break
            }
        }
    }
}



extension DetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return 20
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        
        switch collectionView {
            case hashTagCollectionView:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RestaurantHashTagCollectionViewCell.id, for: indexPath)
               
                if let cell = cell as? RestaurantHashTagCollectionViewCell {
                    cell.model = "#\(String(indexPath.row))"
                }

                return cell
         
            case restaurantMenuCollectionView:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RestaurantMenuCollectionViewCell.id, for: indexPath)
               
                if let cell = cell as? RestaurantMenuCollectionViewCell {
                    cell.menuTitle.text = "싸이버거"
                    cell.menuDiscription.text = "맘스터치 대표메뉴 "
                }
         
                return cell
         
            default:
                return UICollectionViewCell()
        }
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {

        switch collectionView {

        case hashTagCollectionView:
            return CGSize(width: 40, height: 30)

        case restaurantMenuCollectionView:
            return CGSize(width: 150, height: 208)

        default:
            return CGSize(width: 40, height: 30)
        }
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        return 6
    }
}


extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return 5
    }
    
    func tableView(
        _ tableView: UITableView,
       cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RestaurantDetailTableViewCell.id, for: indexPath) as? RestaurantDetailTableViewCell else {
            return UITableViewCell()
        }
        cell.setUI(data[indexPath.row])
        
        switch indexPath.row {
        case 0:
            
            cell.cellTitleLabel.text = "종류"
            cell.cellDetailTitleLabel.text = "패스프푸드"

        case 1:
            cell.cellTitleLabel.text = "전화번호"
            cell.cellDetailTitleLabel.text = "010-0234-2341"

            
        case 2:
            cell.cellTitleLabel.text = "지역"
            cell.cellDetailTitleLabel.text = "경희대 입"

        case 3:
            cell.cellTitleLabel.text = "가격대"
            cell.cellDetailTitleLabel.text = "10000원 대"
            
        case 4:
            cell.cellTitleLabel.text = "영업시간"
            cell.cellDetailTitleLabel.text = "09:00 - 11:00"
            
        default:
            return UITableViewCell()
        }
        
        return cell
    }
    
    func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath
    ) -> CGFloat {
        return UITableView.automaticDimension
    }
}






