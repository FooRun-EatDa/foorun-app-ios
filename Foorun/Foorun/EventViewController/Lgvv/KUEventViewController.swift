//
//  KUEventViewController.swift
//  Foorun
//
//  Created by Hamlit Jason on 2022/08/16.
//

import UIKit
import SnapKit

class KUEventViewController: UIViewController {
    
    // MARK: - Properties
    var events: [String] = []
    
    // MARK: - IBOutlets
    let collectioView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("\(#function)")
        setupNavigationBar()
        setupViews()
    }
    
    func setupNavigationBar() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.title = "이벤트"
    }
    
    func setupViews() {
        view.addSubview(collectioView)
        collectioView.register(
            KUEventCollectionViewCell.self,
            forCellWithReuseIdentifier: KUEventCollectionViewCell.identifier
        )
        collectioView.delegate = self
        collectioView.dataSource = self
        
        collectioView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension KUEventViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 11
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: KUEventCollectionViewCell.identifier,
            for: indexPath
        ) as? KUEventCollectionViewCell else { return UICollectionViewCell() }
        
        cell.backgroundColor = .red
        cell.setUI("asd")
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let spacing: CGFloat = 10
        let width: CGFloat = (UIScreen.main.bounds.width - spacing) / 2
        let height: CGFloat = width * 1.6
        
        return CGSize(width: width, height: height)
    }
    
}

class KUEventCollectionViewCell: UICollectionViewCell {
    static let identifier = String(describing: self)
    
    var imageView = UIImageView()
    var eventTitleLabel = UILabel()
    var restaurantTitleLabel = UILabel()
    var dateLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setupImageView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // NOTE: - Model 변경
    func setUI(_ item: String) { }
    
    func setupImageView() {
        addSubview(imageView)
        
        imageView.snp.makeConstraints {
            $0.top.left.trailing.bottom.equalToSuperview()
        }
    }
}
