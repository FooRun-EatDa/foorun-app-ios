//import UIKit
//import SnapKit
//
//class NoEventNoticeView: UIView {
//    private lazy var noEventLabel: UILabel = {
//        let label = UILabel()
//        label.text = "현재 진행중인 이벤트가 없어요..ㅠ😢"
//        label.font = .systemFont(ofSize: 21, weight: .semibold)
//        label.isUserInteractionEnabled = false
//
//        return label
//    }()
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        layout()
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//}
//
//extension NoEventNoticeView {
//    private func layout() {
//        addSubview(noEventLabel)
//
//        noEventLabel.snp.makeConstraints {
//            $0.centerX.centerY.equalToSuperview()
//        }
//    }
//}
