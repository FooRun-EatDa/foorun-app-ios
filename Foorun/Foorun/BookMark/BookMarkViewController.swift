import UIKit
import SnapKit
import Then

class KUBookmarkViewController: UIViewController {
    // MARK: Views
    /// 북마크뷰 타이틀
    let bookmarkViewTitle = UILabel().then {
        $0.text = "찜한 맛집"
        $0.font = UIFont.boldSystemFont(ofSize: 25)
    }
    /// 북마크 개수 Label: 총 n개
    let bookmarksSizeLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 12)
    }
    let emptyView = UIView()
    let emptyLabel = UILabel().then {
        $0.text = "현재 찜한 식당이 없습니다."
    }
    /// 북마크 테이블 뷰
    lazy var bookmarkTableView = UITableView().then {
        $0.separatorInset.left = 0
    }
    // MARK: - Properties
    /// 삭제에 사용할 캐시
    var deleteCache: Set<Int> = Set<Int>()
    /// 로컬에 저장된 북마크 리스트 정보.
    @UserDefault(key: "bookmarkList", defaultValue: [])
    var bookmarkList: [RestaurantList]
    // MARK: - Method
    ///찜한 목록이 0개면 찜 없다 표시 (리젝 사유 때문에)
    func checkTableView(){
        if bookmarkList.count == 0 {
            bookmarkTableView.isHidden = true
            emptyView.isHidden = false
        } else {
            bookmarkTableView.isHidden = false
            emptyView.isHidden = true
        }
        bookmarksSizeLabel.text = "총 \(bookmarkList.count)개"
    }
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
        setupEmptyView()
        setupEmptyLabel()
        setupBookmarkTableView()
        checkTableView()
    }
}
// MARK: TableView
extension KUBookmarkViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return bookmarkList.count
        
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
        var actions: [UIContextualAction] = []
        let delete = UIContextualAction(style: .normal, title: nil, handler: {(action, view, completionHandler) in
            if let safeId = self.bookmarkList[indexPath.row].id {
                self.deleteCache.insert(safeId)
            }
            self.bookmarkList.remove(at: indexPath.row)
            tableView.reloadData()
            self.checkTableView()
        })
        delete.image = UIImage(systemName: "trash")
        delete.backgroundColor = UIColor.red
        actions.append(delete)
        return UISwipeActionsConfiguration(actions: actions)
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let id = bookmarkList[indexPath.row].id {
            print(id)
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.width * (76/376) + 25.96
    }
}

// MARK: setUpViews
extension KUBookmarkViewController {
    func setupEmptyLabel(){
        emptyView.addSubview(emptyLabel)
        emptyLabel.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
    }
    func setupTitle(){
        view.addSubview(bookmarkViewTitle)
        bookmarkViewTitle.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            $0.leading.equalToSuperview().offset(22.54)
        }
    }
    func setupBookmarksSizeLabel(){
        view.addSubview(bookmarksSizeLabel)
        
        bookmarksSizeLabel.snp.makeConstraints {
            $0.top.equalTo(bookmarkViewTitle.snp.bottom).offset(12.74)
            $0.leading.equalTo(bookmarkViewTitle)
        }
    }
    func setupBookmarkTableView() {
        view.addSubview(bookmarkTableView)
        bookmarkTableView.register(KUBookmarkTableViewCell.self, forCellReuseIdentifier: KUBookmarkTableViewCell.identifier)
        bookmarkTableView.snp.makeConstraints {
            $0.top.equalTo(bookmarksSizeLabel.snp.bottom).offset(7.9)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        bookmarkTableView.dataSource = self
        bookmarkTableView.delegate = self
    }
    func setupEmptyView () {
        view.addSubview(emptyView)
        emptyView.snp.makeConstraints {
            $0.top.equalTo(bookmarksSizeLabel.snp.bottom).offset(7.9)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
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
