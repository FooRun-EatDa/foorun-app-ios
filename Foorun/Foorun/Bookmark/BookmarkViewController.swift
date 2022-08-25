import UIKit
import SnapKit
import FoorunKey

class BookmarkViewController: UIViewController, UpdateBookmark {
    func updateBookmark() {
        bookmarks = UserDefaultManager.shared.bookmarks
    }
    
    // MARK: - IBOutlets
    
    let bookmarkView = BookmarkView()

    // MARK: - Properties
    
    /// 삭제에 사용할 캐시
    var deleteCache: [Int] = []
    /// 로컬에 저장된 북마크 리스트 정보.
    var bookmarks: [RestaurantDetail] = UserDefaultManager.shared.bookmarks {
        didSet {
            UserDefaultManager.shared.bookmarks = bookmarks
            updateBookmarks()
        }
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "찜한 목록"

        bookmarkView.tableView.delegate = self
        bookmarkView.tableView.dataSource = self
    }
    
    // MARK: - Method
    
    func updateBookmarks() {
        bookmarkView.tableView.isHidden = bookmarks.count == 0
        ? true
        : false
        bookmarkView.countLabel.text = "총 \(bookmarks.count)개"
        bookmarkView.tableView.reloadData()
    }
    
    func setupViews(){
        view.addSubview(bookmarkView)
        
        bookmarkView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.bottom.trailing.equalToSuperview()
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        bookmarks = UserDefaultManager.shared.bookmarks
//        bookmarks =  UserDefaultManager.shared.bookmarks
        
    }
    
    /// 삭제 캐시를 서버에 보내고 캐시 정리 (캐시를 언제 어디서 쓸지 추후에 정리)
    func delete() {
        API<String>(
            requestString: FoorunRequest.Restaurant.bookmarkingList,
            method: .delete,
            parameters: ["markingList": deleteCache]
        ).fetch { apiResponse in
            print(apiResponse)
            guard let _ = apiResponse.data else { return }
        }
        
        deleteCache = []
    }
    
}
