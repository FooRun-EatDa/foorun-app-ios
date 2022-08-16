import UIKit
import SnapKit

class EventDetailViewController: UIViewController {
    //MARK: - Property
    var eventDetail: Event.Detail

    //MARK: - SubComponents
    private let scrollView = UIScrollView()
    private lazy var couponBottomView = CouponBottomView(
        eventID: eventDetail.id,
        expiredDate: eventDetail.expiredDate
    )
    private lazy var eventPosterView = EventPosterView(
        imageURL: eventDetail.imageURL,
        eventID: eventDetail.id
    )
    private lazy var eventDescriptionView = EventDescriptionView(
        eventInfo: eventDetail
    )
    private lazy var blankView = BlankView()
    private lazy var overlayView = UIView()

    init(eventDetail: Event.Detail) {
        self.eventDetail = eventDetail
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        couponBottomView.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        layoutNavigationBar()
        layout()
    }
}

//MARK: - Layout
extension EventDetailViewController {
    private func layoutNavigationBar() {
        title = "이벤트"
        navigationController?.navigationBar.backgroundColor = .white
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]
        navigationController?.navigationBar.topItem?.backButtonDisplayMode = .minimal
        navigationController?.navigationBar.tintColor = .black
    }

    private func layout() {
        view.backgroundColor = .white
        view.addSubviews([scrollView, couponBottomView])
        layoutScrollView()
        layoutCouponBottomView()
        layoutOverlayView()
    }

    private func layoutScrollView() {
        scrollView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        scrollView.addSubviews([eventPosterView, eventDescriptionView, blankView])

        eventPosterView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.width.equalToSuperview()
        }

        eventDescriptionView.snp.makeConstraints {
            $0.top.equalTo(eventPosterView.snp.bottom).offset(26.53)
            $0.leading.trailing.equalToSuperview()
            $0.width.equalToSuperview()
        }

        blankView.snp.makeConstraints {
            $0.top.equalTo(eventDescriptionView.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()

            // blankView의 bottom이 safeAreaBottom위까지 오는 것에 대처
            let bottomSafeAreaHeight = calculateBottomSafeAreaHeight()
            $0.height.equalTo(133.31 - bottomSafeAreaHeight)
            $0.width.equalToSuperview()
        }
    }

    private func layoutOverlayView() {
        guard let usedCoupon = UserDefaults.standard.array(forKey: "UsedCoupons") as? [Int],
              usedCoupon.contains(eventDetail.id) else { return }
        overlayView.isUserInteractionEnabled = false
        overlayView.backgroundColor = .black.withAlphaComponent(0.5)
        navigationController?.navigationBar.backgroundColor = .clear

        view.addSubview(overlayView)
        overlayView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    private func layoutCouponBottomView() {
        couponBottomView.layer.shadowColor = UIColor.black.cgColor
        couponBottomView.layer.shadowOffset = CGSize(width: 0, height: 0)
        couponBottomView.layer.shadowOpacity = 0.28
        couponBottomView.layer.shadowRadius = 5

        couponBottomView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(105.36)
        }
    }

    private func calculateBottomSafeAreaHeight() -> CGFloat {
        let connectedScenes = UIApplication.shared.connectedScenes
            .filter { $0.activationState == .foregroundActive }
            .compactMap { $0 as? UIWindowScene }
        let window = connectedScenes.first?.windows.first { $0.isKeyWindow }
        let bottomSafeAreaHeight = window?.safeAreaInsets.bottom ?? 34

        return bottomSafeAreaHeight
    }
}

//MARK: - CouponBottomView Delegate
extension EventDetailViewController: CouponBottomViewDelegate {
    func alert(controller: UIAlertController, actions: [UIAlertAction]) {
        self.showsAlert(controller: controller, actions: actions)
    }

    func dismiss() {
        dismiss(animated: true)
    }
}
