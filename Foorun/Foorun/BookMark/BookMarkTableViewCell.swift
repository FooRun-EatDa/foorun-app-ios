import UIKit
import Then
import Kingfisher

class KUBookmarkTableViewCell: UITableViewCell {
    static let identifier = String(describing: self)
    
    // MARK: Views
    /// 식당 메인 이미지
    let thumnailImageView = UIImageView().then {
        $0.backgroundColor = UIColor(red: 0.769, green: 0.769, blue: 0.769, alpha: 1)
        $0.layer.cornerRadius = 17
        $0.clipsToBounds = true
    }
    /// 스택뷰 (식당 이름, 설명, 해시테크 vertical)
    let VStackView = UIStackView()
    /// 식당 이름 Label
    let nameLabel = UILabel().then {
        $0.font = UIFont.boldSystemFont(ofSize: 14)
    }
    /// 식당 설명 Label
    let explanationLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 14)
    }
    /// 식당 해시태그 Label
    let hashTagLabel = UILabel().then {
        $0.font = UIFont.preferredFont(forTextStyle: .caption2)
        $0.textColor = .gray
        $0.numberOfLines = 2
    }
    // MARK: - Properties
    
    // MARK: - Method
    /// 해시 태그 문자열 배열을 String으로 합쳐서 반환
    /// ex) ["정건", "다양함"] -> "#정건 #다양함 "
    private func hashTagToString(_ strings: [String]) -> String {
        return strings.enumerated().map { $0 == (strings.count - 1) ? "#\($1)" : "#\($1) " }.reduce("", +) + "\n"
    }
    
    // MARK: - Life Cycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupThumbnailImageView()
        setupVStackView()
    }
    required init?(coder aDecoder: NSCoder){
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Cell
    /// 셀 정보를 초기화
    func configure(_ item: RestaurantList?) {
        guard let item = item else { return }
        nameLabel.text = item.name
        explanationLabel.text = item.explanation
        hashTagLabel.text = hashTagToString(item.hashTags)
        guard let url = URL(string: item.imgUrl ?? "") else { return }
        thumnailImageView.kf.setImage(with: url)
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        thumnailImageView.image = nil
    }
}

// MARK: SetupViews
extension KUBookmarkTableViewCell {
    private func setupThumbnailImageView() {
        contentView.addSubview(thumnailImageView)
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

        // 스택뷰에 들어가는 뷰들
        [nameLabel, explanationLabel, hashTagLabel].forEach { VStackView.addArrangedSubview($0) }
    }
}
