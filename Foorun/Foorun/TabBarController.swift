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
        viewController.setupLargetTitle()
        
        return viewController
    }()

    private lazy var eventViewController: UIViewController = {
        let viewController = UINavigationController(rootViewController: EventViewController())

        viewController.tabBarItem = UITabBarItem(
            title: "이벤트",
            image: UIImage(named: AssetSet.TabBarItem.event),
            tag: 2
        )
        viewController.setupLargetTitle()
        
        return viewController
    }()

    private lazy var myPageViewController: UIViewController = {
        let viewController = UINavigationController(rootViewController: MyPageViewController())
        
        viewController.tabBarItem = UITabBarItem(
            title: "마이",
            image: UIImage(named: AssetSet.TabBarItem.my),
            tag: 3
        )
        viewController.setupLargetTitle()
        
        return viewController
    }()

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTabBar()
        viewControllers = [mapViewContoller, bookmarkViewController, eventViewController, myPageViewController]
    }

    private func setupTabBar() {
        tabBar.backgroundColor = .white
        tabBar.tintColor = .black

        tabBar.layer.shadowOffset = CGSize(width: 0, height: 0)
        tabBar.layer.shadowRadius = 9
        tabBar.layer.shadowColor = UIColor.black.cgColor
        tabBar.layer.shadowOpacity = 0.1
    }
}

private extension UINavigationController {
    func setupLargetTitle() {
        self.navigationBar.largeTitleTextAttributes = [
            .font: UIFont.systemFont(ofSize: 25, weight: .bold)
        ]
    }
}
