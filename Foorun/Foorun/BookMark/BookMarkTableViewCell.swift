//
//  BookMarkTableViewCell.swift
//  Foorun
//
//  Created by 김지훈 on 2022/07/31.
//

import UIKit

class BookMarkTableViewCell: UITableViewCell {
    // imageView 생성
    let img: UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage(named: "icon")
        return imgView
    }()
    // label 생성
    let label: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.gray
        return label
    }()
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpView()
        setConstraint()
    }
    
    required init?(coder aDecoder: NSCoder){
        fatalError("init(coder:) has not been implemented")
    }
    private func setUpView(){
        contentView.addSubview(img)
        contentView.addSubview(label)
    }
    private func setConstraint() {

            
        img.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        img.snp.makeConstraints { make in
            make.leading.top.equalTo(5)
            make.size.width.height.equalTo(100)
        }
        label.snp.makeConstraints {
            $0.leading.equalTo(img.snp.trailing).offset(5)
            $0.top.equalTo(5)
            $0.trailing.equalTo(-5)
        }
    }
}
