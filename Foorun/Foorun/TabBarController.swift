import UIKit
import SwiftUI
class TabBarController: UITabBarController {
    private lazy var mapViewContoller: UIViewController = {
        let viewController = UINavigationController(rootViewController: MapViewController())
        
        viewController.tabBarItem = UITabBarItem(
            title: "홈",
            image: UIImage(named: AssetSet.TabBarItem.home),
            tag: 1
        )
        
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
            tag: 1
        )

        return viewController
    }()
    
    private lazy var settingViewController: UIViewController = {
        let settingViewController = UIHostingController(rootView: SettingView())
        let viewController = UINavigationController(rootViewController: settingViewController)
        
        viewController.tabBarItem = UITabBarItem(
            title: "마이",
            image: UIImage(named: AssetSet.TabBarItem.my),
            tag: 1
        )
        
        return viewController
    }()
    
    // MARK: - 🎉 BIRTHDAY
    private lazy var birthDayViewController: UIViewController = {
        let viewController = UINavigationController(rootViewController: EntryViewController())
        
        viewController.tabBarItem = UITabBarItem(
            title: "",
            image: UIImage(named: "birthday"),
            tag: 1
        )
        
        return viewController
    }()
    
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        tabBar.backgroundColor = .white
        tabBar.tintColor = UIColor(red: 255.0/255.0, green: 193.0/255.0, blue: 7.0/255.0, alpha: 1)
        viewControllers = [mapViewContoller, bookmarkViewController, eventViewController, settingViewController, birthDayViewController]
    }
}
