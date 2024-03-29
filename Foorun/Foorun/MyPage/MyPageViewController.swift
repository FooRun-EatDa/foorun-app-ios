//
//  MyPageViewController.swift
//  Foorun
//
//  Created by 김지훈 on 2022/09/14.
//

import UIKit

class MyPageViewController: UIViewController {
    
    // MARK: - Properties
    
    var viewModel: MyPageViewModel = MyPageViewModel()
    
    var dataSource: UICollectionViewDiffableDataSource<MyPageSection, MyPageItem>! = nil

    
    // MARK: - IBOutlets
    var myPageCollectionVeiw = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(updateToken), name: Notification.Name("verificationCompleted"), object: nil)
        navigationItem.title = viewModel.title
        setupMyPageCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.largeTitleDisplayMode = .always
    }
    
    // MARK: - Methods
    @objc
    func updateToken() {
        viewModel.updateName()
        performSnapshot()
    }
}

extension MyPageViewController {
    func setupMyPageCollectionView() {
        view.addSubview(myPageCollectionVeiw)
        
        myPageCollectionVeiw.collectionViewLayout = createLayout()
        myPageCollectionVeiw.isScrollEnabled = false
        myPageCollectionVeiw.delegate = self
        
        myPageCollectionVeiw.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
        configurationDataSource()
    }
}

