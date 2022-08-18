import UIKit
import SnapKit

class BookmarkViewController: UIViewController {
    
    let bookmarkView = BookmarkView()

    // MARK: - Properties
    
    /// 삭제에 사용할 캐시
    var deleteCache: Set<Int> = []
    /// 로컬에 저장된 북마크 리스트 정보.
    ///
    var bookmarks: [RestaurantList] = UserDefaultManager.shared.bookmarks {
        didSet {
            UserDefaultManager.shared.bookmarks = bookmarks
            updateBookmarks()
        }
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        updateBookmarks()
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "찜한 목록"
  
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
