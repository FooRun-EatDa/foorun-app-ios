//
//  MyPageDetailViewController.swift
//  Foorun
//
//  Created by 김지훈 on 2022/09/14.
//

import UIKit

class MyPageDetailViewController: UIViewController {
    // MARK: - IBOutlets
    var viewModel = MyPageViewModel(title: "", menus: [""])
    var myPageDetailCollectionVeiw = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    
    // MARK: - Properties
    var dataSource: UICollectionViewDiffableDataSource<MyPageDetailSection, MyPageDetailItem>! = nil
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = viewModel.title
        view.backgroundColor = .systemBackground
        
        setupMyPageCollectionView()
    }
    
    // MARK: - Methods
    func setupMyPageCollectionView() {
        view.addSubview(myPageDetailCollectionVeiw)
        
        myPageDetailCollectionVeiw.collectionViewLayout = createLayout()
        myPageDetailCollectionVeiw.isScrollEnabled = false
        myPageDetailCollectionVeiw.delegate = self
        
        myPageDetailCollectionVeiw.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
        configurationDataSource()
    }
    
}


                                                        
                                                        
                                                        
                                                        
