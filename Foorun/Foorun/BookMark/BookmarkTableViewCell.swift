import UIKit
import Kingfisher

class BookmarkTableViewCell: UITableViewCell {
    static let identifier = String(describing: self)
    
    // MARK: - IBOutlet
    
    /// 식당 메인 이미지
    let thumnailImageView = UIImageView()
    /// 스택뷰 (식당 이름, 설명, 해시테크 vertical)
    let VStackView = UIStackView()
    /// 식당 이름 Label
    let titleLabel = UILabel()
    /// 식당 설명 Label
    let explanationLabel = UILabel()
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        thumnailImageView.image = nil
    }
}

extension BookmarkTableViewCell {
    
    public func configure(_ item: RestaurantList?) {
        guard let item = item else { return }
        
        titleLabel.text = item.name
        explanationLabel.text = item.explanation
        tagLabel.text = tagsToString(item.hashTags)
        
        guard let url = URL(string: item.imgUrl ?? "") else { return }
        thumnailImageView.kf.setImage(with: url)
    }
    
    private func tagsToString(_ tags: [String]) -> String {
        tags.map { "#\($0)" }
            .reduce("", +)
            .trimmingCharacters(in: .whitespaces)
        + "\n"
    }
    
    private func setupThumbnailImageView() {
        contentView.addSubview(thumnailImageView)
        
        thumnailImageView.backgroundColor = UIColor(red: 0.769, green: 0.769, blue: 0.769, alpha: 1)
        thumnailImageView.layer.cornerRadius = 17
        thumnailImageView.clipsToBounds = true
        
        let size = UIScreen.main.bounds.width * (76/376)
        
        thumnailImageView.snp.makeConstraints {
            $0.width.height.equalTo(size)
            $0.top.equalToSuperview().offset(12.98)
            $0.leading.equalToSuperview().offset(22.54)
        }
    }
    
    func setupVStackView() {
        contentView.addSubview(VStackView)
        VStackView.axis = .vertical
        VStackView.distribution = .fillProportionally
        
        VStackView.snp.makeConstraints {
            $0.top.equalTo(thumnailImageView.snp.top)
            $0.leading.equalTo(thumnailImageView.snp.trailing).offset(22.54)
            $0.trailing.bottom.equalToSuperview()
        }
        
        titleLabel.font = UIFont.boldSystemFont(ofSize: 14)
        explanationLabel.font = UIFont.systemFont(ofSize: 14)
        
        tagLabel.font = UIFont.preferredFont(forTextStyle: .caption2)
        tagLabel.textColor = .gray
        tagLabel.numberOfLines = 2
        // 스택뷰에 들어가는 뷰들
        [titleLabel, explanationLabel, tagLabel].forEach { VStackView.addArrangedSubview($0) }
    }
}
