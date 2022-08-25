//
//  BookmarkViewController.UITableView.swift
//  Foorun
//
//  Created by 김지훈 on 2022/08/16.
//

import UIKit
import SnapKit
class BookmarkView: UIView {
    // MARK: - IBOutlet
    
    /// 북마크 개수 Label: 총 n개
    let countLabel = UILabel()
    /// 찜한 식당이 없을 경우 표시되는 라벨
    let emptyLabel = UILabel()
    /// 북마크 테이블 뷰
    let tableView = UITableView()
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: .zero)

        setupCountLabel()
        setupEmptyLabel()
        setupTableView()
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension BookmarkView {
    func setupEmptyLabel() {
        addSubview(emptyLabel)
        
        emptyLabel.text = "현재 찜한 식당이 없어요..😵"
        
        emptyLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(-50)
        }
    }
    func setupCountLabel() {
        addSubview(countLabel)
        
        countLabel.font = UIFont.systemFont(ofSize: 12)
        
        countLabel.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.leading.equalToSuperview().offset(22)
        }
    }
    
    func setupTableView() {
        addSubview(tableView)
        
        tableView.rowHeight = 106
        tableView.separatorInset.left = 0
        tableView.register(BookmarkTableViewCell.self, forCellReuseIdentifier: BookmarkTableViewCell.identifier)
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(countLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
}
