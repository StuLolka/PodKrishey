import UIKit

enum AppFactory {
    static func getViewControllers() -> [UIViewController] {
        let homeItem = UITabBarItem(title: nil, image: .TabBar.house, tag: 0)
        let likedItem = UITabBarItem(title: nil, image: .TabBar.heart, tag: 0)
        let profileItem = UITabBarItem(title: nil, image: .TabBar.person, tag: 0)
        
        let homeNC = HomeFactory.getViewController()
        let likedNC = UINavigationController(rootViewController: LikedViewController())
        let profileNC = LoginFactory.getViewController()
        
        homeNC.tabBarItem = homeItem
        
        likedNC.tabBarItem = likedItem
        likedNC.navigationBar.barTintColor = .Global.blue
        likedNC.navigationBar.backgroundColor = .Global.blue
        
        profileNC.tabBarItem = profileItem
        
        return [homeNC, likedNC, profileNC]
    }
}
