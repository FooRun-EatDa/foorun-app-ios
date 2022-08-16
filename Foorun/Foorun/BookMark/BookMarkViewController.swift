import UIKit
import SnapKit

class KUBookmarkViewController: UIViewController {
    // MARK: Views
    /// 북마크뷰 타이틀
    let bookmarkViewTitleLabel = UILabel()
    /// 북마크 개수 Label: 총 n개
    let bookmarksSizeLabel = UILabel()
    /// 찜한 식당이 없을 경우 표시되는 라벨
    let emptyLabel = UILabel()
    /// 북마크 테이블 뷰
    let bookmarkTableView = UITableView()
    
    // MARK: - Properties
    /// 삭제에 사용할 캐시
    var deleteCache: Set<Int> = Set<Int>()
    /// 로컬에 저장된 북마크 리스트 정보.
    @UserDefault(key: "bookmarkList", defaultValue: [])
    var bookmarkList: [RestaurantList] {
        didSet {
            bookmarkTableView.isHidden = bookmarkList.count == 0
            ? true
            : false
            bookmarksSizeLabel.text = "총 \(bookmarkList.count)개"
        }
    }
    
    // MARK: - Method
    /// 삭제 캐시를 서버에 보내고 캐시 정리 (아직 api구현 대기중)
    private func delete() {
        // 1. 로컬 업데이트
        // 2. API Request Update -> set
        deleteCache = []
    }
    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTitle()
        setupBookmarksSizeLabel()
        setupEmptyLabel()
        setupBookmarkTableView()
    }
}
// MARK: TableView
extension KUBookmarkViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        bookmarkList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: KUBookmarkTableViewCell.identifier,
            for: indexPath
        ) as? KUBookmarkTableViewCell else { return UITableViewCell() }
        
        cell.configure(bookmarkList[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

        let delete = UIContextualAction(style: .normal, title: nil) { _, _, _ in
            guard let restaurantId = self.bookmarkList[indexPath.row].id else { return }
            self.deleteCache.insert(restaurantId)
            self.bookmarkList.remove(at: indexPath.row)
            tableView.reloadData()
        }
        
        delete.image = UIImage(systemName: "trash")
        delete.backgroundColor = UIColor.red
        
        let swipeAction = UISwipeActionsConfiguration(actions: [delete])

        return swipeAction
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let id = bookmarkList[indexPath.row].id else { return }
        
        // TODO: - 화면전환
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.width * (76/376) + 25.96
    }
}

// MARK: setUpViews
extension KUBookmarkViewController {
    func setupEmptyLabel() {
        view.addSubview(emptyLabel)
        
        emptyLabel.text = "현재 찜한 식당이 없습니다."
        
        emptyLabel.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
    }
    func setupTitle() {
        view.addSubview(bookmarkViewTitleLabel)
        
        bookmarkViewTitleLabel.text = "찜한 맛집"
        bookmarkViewTitleLabel.font = UIFont.boldSystemFont(ofSize: 25)
        
        bookmarkViewTitleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            $0.leading.equalToSuperview().offset(22.54)
        }
    }
    func setupBookmarksSizeLabel() {
        view.addSubview(bookmarksSizeLabel)
        
        bookmarksSizeLabel.font = UIFont.systemFont(ofSize: 12)
        
        bookmarksSizeLabel.snp.makeConstraints {
            $0.top.equalTo(bookmarkViewTitleLabel.snp.bottom).offset(12.74)
            $0.leading.equalTo(bookmarkViewTitleLabel)
        }
    }
    func setupBookmarkTableView() {
        view.addSubview(bookmarkTableView)
        
        bookmarkTableView.separatorInset.left = 0
        bookmarkTableView.register(KUBookmarkTableViewCell.self, forCellReuseIdentifier: KUBookmarkTableViewCell.identifier)
       
        
        bookmarkTableView.snp.makeConstraints {
            $0.top.equalTo(bookmarksSizeLabel.snp.bottom).offset(7.9)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        bookmarkTableView.dataSource = self
        bookmarkTableView.delegate = self
    }


}
/// UserDefaults를 Codable 상태로 사용하기 위한 propertyWrapper
@propertyWrapper
struct UserDefault<T: Codable> {
    private let key: String
    private let defaultValue: T
    public let storage: UserDefaults
    
    init(key: String, defaultValue: T, storage: UserDefaults = .standard) {
        self.key = key
        self.defaultValue = defaultValue
        self.storage = storage
    }

    var wrappedValue: T {
        get {
            // Read value from UserDefaults
            guard let data = self.storage.object(forKey: key) as? Data else {
                // Return defaultValue when no data in UserDefaults
                return defaultValue
            }

            // Convert data to the desire data type
            let value = try? JSONDecoder().decode(T.self, from: data)
            return value ?? defaultValue
        }
        set {
            // Convert newValue to data
            let data = try? JSONEncoder().encode(newValue)

            // Set value to UserDefaults
            UserDefaults.standard.set(data, forKey: key)
        }
    }
}
