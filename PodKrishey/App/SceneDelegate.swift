//
//  SceneDelegate.swift
//  PodKrishey
//
//  Created by Anastasiia on 26.02.2023.
//

import UIKit
import Firebase

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
        
//        FirebaseApp.configure()
        
//        var filePath = Bundle.main.path(forResource: "GoogleService-Info-Auth", ofType: "plist")
//        guard let fileopts = FirebaseOptions(contentsOfFile: filePath!)
//          else { assert(false, "Couldn't load config file") }
//        FirebaseApp.configure(options: fileopts)
//
//        FirebaseApp.

        let filePath = Bundle.main.path(forResource: "GoogleService-Info-Base", ofType: "plist")
        guard let fileopts2 = FirebaseOptions(contentsOfFile: filePath!)
          else { assert(false, "Couldn't load config file") }
        FirebaseApp.configure(options: fileopts2)
        
        coordinator.start()
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
    }

}

