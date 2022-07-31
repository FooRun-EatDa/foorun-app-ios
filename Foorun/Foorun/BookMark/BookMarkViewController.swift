//
//  BookMarkViewController.swift
//  Foorun
//
//  Created by 김지훈 on 2022/07/31.
//

import UIKit
import SnapKit
import Then
class BookMarkViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let bookMarkTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(BookMarkTableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    var Title = UILabel().then {
        $0.text = "찜한 맛집"
        $0.frame = CGRect(x: 0, y: 0, width: 315, height: 34)
        $0.font = UIFont.boldSystemFont(ofSize: 25) // font 다운로드 후 변경
//        $0.textColor = UIColor(red: 0.098, green: 0.098, blue: 0.098, alpha: 1)
//        $0.backgroundColor = .red
    }
    var bookmarks: BookMarkModel?
    var bookMarksSizeLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 12)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        setConstraints()
//        self.bookMarkTableView = UITableView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height))
        bookMarkTableView.dataSource = self
        bookMarkTableView.delegate = self
        bookMarkTableView.rowHeight = 100 // 임시
        bookmarks = BookMarkModel()
        bookMarksSizeLabel.text = "총 \(bookmarks?.size  ?? 0)개"
    }
    func setUpView(){
        view.addSubview(Title)
        view.addSubview(bookMarksSizeLabel)
        view.addSubview(bookMarkTableView)
    }

    func setConstraints(){
        Title.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(22.54)
            make.top.equalToSuperview().offset(97.46)
        }
        bookMarksSizeLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(25.13)
            make.top.equalTo(Title).offset(46.74)
        }
        
        bookMarkTableView.snp.makeConstraints { make in
//            make.edges.equalTo(view)
            make.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
            make.top.equalTo(Title).offset(84.62)
//            make.
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookmarks!.size
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = bookMarkTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! BookMarkTableViewCell
        cell.img.image = UIImage(systemName: "ticket")
        cell.label.text = "cell Index: \(indexPath.row)"
        return cell
    }
    

}

