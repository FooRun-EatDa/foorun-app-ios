//
//  DetailViewController.swift
//  Foorun
//
//  Created by 김희진 on 2022/07/10.
//

import UIKit
import SnapKit
import Then
import RxSwift

class DetailViewController: UIViewController {
        
    let detailView = DetailView()
    var viewModel: DetailViewModel!
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        bind(viewModel, detailView)
    }
    
    init(vm: DetailViewModel) {
        super.init(nibName: nil, bundle: nil) 
        self.viewModel = vm
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        
    func bind(_ viewModel: DetailViewModel, _ view: DetailView) {
        viewModel.data.subscribe(onNext: {
            view.data.onNext($0)
        }).disposed(by: disposeBag)
    }
}

extension DetailViewController {
    func setupView() {
        view.addSubview(detailView)
        detailView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}


