import UIKit
import SwiftUI
class TabBarController: UITabBarController, UITabBarControllerDelegate {
    private lazy var mapViewContoller: UIViewController = {
        let viewController = UINavigationController(rootViewController: MapViewController())
        
        viewController.tabBarItem = UITabBarItem(
            title: "홈",
            image: UIImage(named: AssetSet.TabBarItem.home),
            tag: 0
        )
        viewController.tabBarItem.selectedImage = UIImage(named: AssetSet.TabBarItem.homeFill)
       
        return viewController
    }()
    
    private lazy var bookmarkViewController: UIViewController = {
        let viewController = UINavigationController(rootViewController: BookmarkViewController())
        
        viewController.tabBarItem = UITabBarItem(
            title: "북마크",
            image: UIImage(named: AssetSet.TabBarItem.bookmark),
            tag: 1
        )
        
        return viewController
    }()

    private lazy var eventViewController: UIViewController = {
        let viewController = UINavigationController(rootViewController: EventViewController())

        viewController.tabBarItem = UITabBarItem(
            title: "이벤트", 
            image: UIImage(named: AssetSet.TabBarItem.event),
            tag: 2
        )
        viewController.tabBarItem.selectedImage = UIImage(named: AssetSet.TabBarItem.eventFill)
        return viewController
    }()
    private lazy var myPageViewController: UIViewController = {
        let viewController = UINavigationController(rootViewController: MyPageViewController())
        
        viewController.tabBarItem = UITabBarItem(
            title: "마이",
            image: UIImage(named: AssetSet.TabBarItem.my),
            tag: 3
        )
        
        return viewController
    }()

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.backgroundColor = .white
        tabBar.tintColor = .black
        
        viewControllers = [mapViewContoller, bookmarkViewController, eventViewController, myPageViewController]
        

    }
    
}
