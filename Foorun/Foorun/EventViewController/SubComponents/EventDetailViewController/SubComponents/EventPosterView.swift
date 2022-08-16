//import UIKit
//import SnapKit
//import Kingfisher
//
//class EventPosterView: UIView {
//    //MARK: - Property
//    var imageURL: String?
//    var eventID: Int
//
//    //MARK: - SubComponents
//    private lazy var posterImageView: UIImageView = {
//        let imageView = UIImageView(image: UIImage())
//        imageView.contentMode = .scaleAspectFit
//
//        return imageView
//    }()
//
//    init(imageURL: String?, eventID: Int) {
//        self.imageURL = imageURL
//        self.eventID = eventID
//        super.init(frame: .zero)
//        layout()
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//}
//
////MARK: - Layout
//extension EventPosterView {
//    private func layout() {
//        guard let imageURL = URL(string: imageURL ?? "") else { return }
//        posterImageView.kf.setImage(with: imageURL, placeholder: nil, options: nil) { [weak self] result in
//            guard let self = self else { return }
//            switch result {
//            case .success(let imageResult):
//                let image = imageResult.image
//                let aspectRatio = image.size.width / image.size.height
//                self.addSubview(self.posterImageView)
//                self.posterImageView.snp.makeConstraints {
//                    $0.centerX.centerY.equalToSuperview()
//                    $0.width.equalToSuperview()
//                    $0.height.equalTo(self.posterImageView.snp.width).multipliedBy(1/aspectRatio)
//                    $0.bottom.equalToSuperview()
//                }
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
//    }
//}
