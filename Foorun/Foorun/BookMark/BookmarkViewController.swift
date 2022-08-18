import UIKit
import SnapKit

class BookmarkViewController: UIViewController {
    
    let bookmarkView = BookmarkView()
    
    // MARK: - Properties
    
    /// 삭제에 사용할 캐시
    var deleteCache: Set<Int> = Set<Int>()
    /// 로컬에 저장된 북마크 리스트 정보.
    @UserDefault(key: "bookmarks", defaultValue: [])
    var bookmarks: [RestaurantList] {
        didSet {
            updateBookmarks()
        }
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        updateBookmarks()
        
        bookmarkView.tableView.delegate = self
        bookmarkView.tableView.dataSource = self
    }
    
    // MARK: - Method
    
    func updateBookmarks() {
        bookmarkView.tableView.isHidden = bookmarks.count == 0
        ? true
        : false
        bookmarkView.countLabel.text = "총 \(bookmarks.count)개"
    }
    
    func setupViews(){
        view.addSubview(bookmarkView)
        
        bookmarkView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.bottom.trailing.equalToSuperview()
            
        }
    }
    /// 삭제 캐시를 서버에 보내고 캐시 정리
    private func delete() {
        deleteCache = []
    }
    
}

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
            guard let data = self.storage.object(forKey: key) as? Data else {
                return defaultValue
            }

            let value = try? JSONDecoder().decode(T.self, from: data)
            return value ?? defaultValue
        }
        set {
            let data = try? JSONEncoder().encode(newValue)

            UserDefaults.standard.set(data, forKey: key)
        }
    }
}
