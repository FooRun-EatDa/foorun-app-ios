import UIKit
import Kingfisher

class BookmarkTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlets
     
    /// 식당 메인 이미지
    let thumnailImageView = UIImageView()
    /// 스택뷰 (식당 이름, 설명, 해시테크 vertical)
    let VStackView = UIStackView()
    /// 식당 이름 Label
    let titleLabel = UILabel()
    /// 식당 설명 Label
    let descriptionLabel = UILabel()
    /// 식당 해시태그 Label
    let tagLabel = UILabel()
    
    // MARK: - Life Cycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupThumbnailImageView()
        setupVStackView()
    }
    
    required init?(coder aDecoder: NSCoder){
        fatalError("init(coder:) has not been implemented")
    }
}

extension BookmarkTableViewCell {
    
    public func configure(_ item: Restaurant?) {
        guard let item = item else { return }
        
        thumnailImageView.kf.setImage(with: URL(string: item.imgUrl ?? ""),placeholder: UIImage(named: "defaultImage"))
        
        titleLabel.text = item.name
        descriptionLabel.text = item.explanation
        tagLabel.text = tagsToString(item.hashTags)
        
        
    }
    override func prepareForReuse() {
        thumnailImageView.image = nil
    }
    private func tagsToString(_ tags: [String]) -> String {
        tags.map { "#\($0)" }
            .reduce("", +)
            .trimmingCharacters(in: .whitespaces)
        + "\n"
    }
    
    private func setupThumbnailImageView() {
        contentView.addSubview(thumnailImageView)
        
        thumnailImageView.layer.cornerRadius = 12
        thumnailImageView.clipsToBounds = true
        
        thumnailImageView.snp.makeConstraints {
            $0.width.height.equalTo(80)
            $0.top.equalToSuperview().offset(13)
            $0.leading.equalToSuperview().offset(22)
        }
    }
    
    func setupVStackView() {
        contentView.addSubview(VStackView)
        
        VStackView.axis = .vertical
        VStackView.distribution = .fillProportionally
        
        VStackView.snp.makeConstraints {
            $0.top.equalTo(thumnailImageView.snp.top)
            $0.leading.equalTo(thumnailImageView.snp.trailing).offset(22)
            $0.trailing.bottom.equalToSuperview()
        }

        [titleLabel, descriptionLabel, tagLabel].forEach { VStackView.addArrangedSubview($0) }
        
        titleLabel.font = UIFont.boldSystemFont(ofSize: 14)
        
        descriptionLabel.font = UIFont.systemFont(ofSize: 14)
        
        tagLabel.font = UIFont.preferredFont(forTextStyle: .caption2)
        tagLabel.textColor = .gray
        tagLabel.numberOfLines = 2
    }
}
