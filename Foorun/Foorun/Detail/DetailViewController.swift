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
import RxCocoa

protocol UpdateBookmark: AnyObject {
    func updateBookmark()
}

class DetailViewController: UIViewController {
    
    weak var delegate: UpdateBookmark?
        
    let detailView = DetailView()
    var viewModel: DetailViewModel!

    let disposeBag = DisposeBag()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        bindView(viewModel, detailView)
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
        
    func bindView(_ viewModel: DetailViewModel, _ view: DetailView) {
        detailView.heartButton.rx.tap
            .bind(to: viewModel.bookmarkButtonTapped)
            .disposed(by: disposeBag)
        
        viewModel.changeBookmarkButton.drive(with: self, onNext: {this, _ in
            this.changeButtonUI()
        }).disposed(by: disposeBag)

        viewModel.data.subscribe(onNext: {
            view.data.accept($0)
        }).disposed(by: disposeBag)
    }
    
    func changeButtonUI() {
        detailView.isBookMarkSelected = !detailView.isBookMarkSelected
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
       
        if viewModel.bookmarks.contains(where: { $0.id == viewModel.id }) {
            if !detailView.isBookMarkSelected {
                UserDefaultManager.shared.bookmarks = UserDefaultManager.shared.bookmarks.filter { $0.id != viewModel.id }
                self.delegate?.updateBookmark()
            }
        } else {
            if detailView.isBookMarkSelected {
                UserDefaultManager.shared.bookmarks.append(viewModel.data.value!)
            }
        }
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


