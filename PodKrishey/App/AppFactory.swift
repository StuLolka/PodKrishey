import UIKit

enum AppFactory {
    static func getViewControllers() -> [UIViewController] {
        let homeItem = UITabBarItem(title: nil, image: .TabBar.house, tag: 0)
        let favoriteItem = UITabBarItem(title: nil, image: .TabBar.heart, tag: 0)
        let profileItem = UITabBarItem(title: nil, image: .TabBar.person, tag: 0)
        
        let homeNC = HomeFactory.getViewController()
        let favoriteNC = FavoriteFactory.getViewController()
        let profileNC = LoginFactory.getViewController()
        
        homeNC.tabBarItem = homeItem
        favoriteNC.tabBarItem = favoriteItem
        profileNC.tabBarItem = profileItem
        
        return [homeNC, favoriteNC, profileNC]
    }
}
