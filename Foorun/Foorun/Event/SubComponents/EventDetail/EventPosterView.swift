import UIKit
import SnapKit

class EventPosterView: UIView {
    //MARK: - Property
    var imageURL: String?

    //MARK: - SubComponents
    private lazy var posterImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage())

        return imageView
    }()

    init(imageURL: String?) {
        self.imageURL = imageURL
        super.init(frame: .zero)
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Layout
extension EventPosterView {
    private func layout() {
        guard let imageURL = imageURL else { return }

        EventNetworkManager.fetchImage(url: imageURL) { [weak self] image in
            guard let self = self,
                  let image = image else { return }

            DispatchQueue.main.async {
                let aspectRatio = image.size.width / image.size.height
                self.posterImageView.image = image

                self.addSubview(self.posterImageView)
                self.posterImageView.snp.makeConstraints {
                    $0.centerX.centerY.equalToSuperview()
                    $0.width.equalToSuperview()
                    $0.height.equalTo(self.posterImageView.snp.width).multipliedBy(1/aspectRatio)
                    $0.bottom.equalToSuperview()
                }
            }
        }
    }
}
