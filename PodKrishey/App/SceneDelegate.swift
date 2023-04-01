//
//  SceneDelegate.swift
//  PodKrishey
//
//  Created by Anastasiia on 26.02.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        
        if #available(iOS 15, *) {
            let navigationBarAppearance = UINavigationBarAppearance()
            navigationBarAppearance.configureWithOpaqueBackground()
            navigationBarAppearance.shadowColor = nil
            navigationBarAppearance.backgroundColor = .Global.blue
            UINavigationBar.appearance().standardAppearance = navigationBarAppearance
            UINavigationBar.appearance().compactAppearance = navigationBarAppearance
            UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
        }
        let tabBarController = UITabBarController()
        let coordinator = AppCoordinator(navigationController: tabBarController)
        coordinator.start()
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
    }
}

