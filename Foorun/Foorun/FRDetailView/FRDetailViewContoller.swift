//
//  FRDetailViewContoller.swift
//  Foorun
//
//  Created by Hamlit Jason on 2022/07/24.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class FRDetailViewContoller: UIViewController {
    let disposBag = DisposeBag()
    
    /// 디테일뷰
    let FRDetailView = FRDetatilView()
    /// 뷰모델
    let viewModel = FRDetailViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        bind(viewModel, FRDetailView)
    }
    
    func bind(_ viewModel: FRDetailViewModel, _ view: FRDetatilView) {
        
    }
}

extension FRDetailViewContoller {
    func setupView() {
        view.addSubview(FRDetailView)
        
        FRDetailView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
