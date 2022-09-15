//
//  MyPageDetailViewController.swift
//  Foorun
//
//  Created by 김지훈 on 2022/09/14.
//

import UIKit

class MyPageDetailViewController: UIViewController {
    
    // MARK: - Properties
    var dataSource: UICollectionViewDiffableDataSource<MyPageDetailSection, MyPageDetailItem>!

    // MARK: - IBOutlets
    var viewModel: MyPageViewModel
    var myPageDetailCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    
    // MARK: - Initializer
    init(dataSource: UICollectionViewDiffableDataSource<MyPageDetailSection, MyPageDetailItem>? = nil, viewModel: MyPageViewModel) {
        self.dataSource = dataSource
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
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
        view.addSubview(myPageDetailCollectionView)
        
        myPageDetailCollectionView.collectionViewLayout = createLayout()
        myPageDetailCollectionView.isScrollEnabled = false
        myPageDetailCollectionView.delegate = self
        
        myPageDetailCollectionView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
        configurationDataSource()
    }
    
}


                                                        
                                                        
                                                        
                                                        
