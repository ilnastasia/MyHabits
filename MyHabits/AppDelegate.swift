
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow()
        
        let habitsController = HabitsViewController()
        let infoController = InfoViewController()
        
        let barAppearance = UINavigationBarAppearance()
        barAppearance.backgroundColor = .white
        
        let navigationBar = UINavigationBar.appearance()
        navigationBar.standardAppearance = barAppearance
        navigationBar.scrollEdgeAppearance = barAppearance
        
        let tabbarAppearance = UITabBarAppearance()
        tabbarAppearance.backgroundColor = .systemGray6
        
        let tabbar = UITabBar.appearance()
        tabbar.tintColor = Colors.purple
        tabbar.standardAppearance = tabbarAppearance
        tabbar.scrollEdgeAppearance = tabbarAppearance

        let tabbarController = UITabBarController()
        
        let infoPage = UINavigationController(rootViewController: infoController)
        let infoPageItem = UITabBarItem()
        infoPageItem.title = "Информация"
        infoPageItem.image = UIImage(systemName: "info.circle.fill")
        infoPage.tabBarItem = infoPageItem
        
        let mainPage = UINavigationController(rootViewController: habitsController)
        let mainPageItem = UITabBarItem()
        mainPageItem.title = "Привычки"
        mainPageItem.image = UIImage(systemName: "rectangle.grid.1x2.fill")
        mainPage.tabBarItem = mainPageItem
        
        tabbarController.viewControllers = [mainPage, infoPage]
        
        window?.rootViewController = tabbarController
        window?.makeKeyAndVisible()
        
        return true
    }
}

