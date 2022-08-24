import UIKit
import SnapKit
import FoorunKey

class BookmarkViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    let bookmarkView = BookmarkView()

    // MARK: - Properties
    
    /// 삭제에 사용할 캐시
    var deleteCache: Set<Int> = []
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
    }
    
    func setupViews(){
        view.addSubview(bookmarkView)
        
        bookmarkView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //TODO: 새로고침 안되길래 임시로 넣어놨습니다. 확인 후 수정해주세요!
        bookmarks =  UserDefaultManager.shared.bookmarks
        bookmarkView.tableView.reloadData()
    }
    
    /// 삭제 캐시를 서버에 보내고 캐시 정리
    func delete() {
        API<Int?>(
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
