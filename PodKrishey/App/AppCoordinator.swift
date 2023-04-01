import UIKit

final class AppCoordinator {
    private let tabBarController: UITabBarController
    
    init(navigationController: UITabBarController) {
        self.tabBarController = navigationController
    }
    
    func start() {
        showMainTabBarController()
    }
    
    private func showMainTabBarController() {
        tabBarController.tabBar.barTintColor = .Global.blue
        tabBarController.tabBar.backgroundColor = .Global.blue
        tabBarController.tabBar.tintColor = .white
        tabBarController.tabBar.unselectedItemTintColor = .black
        tabBarController.tabBar.isTranslucent = false
        tabBarController.viewControllers = AppFactory.getViewControllers()
//        childs.append(tabBar)
    }
}
