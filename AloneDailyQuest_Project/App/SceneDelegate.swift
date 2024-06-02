//
//  SceneDelegate.swift
//  AloneDailyQuest_Project
//
//  Created by Designer on 11/16/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    var appCoordinator: AppCoordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        
        let launchSreenViewController = LaunchScreenViewController()
        
        self.window?.rootViewController = launchSreenViewController
        self.window?.makeKeyAndVisible()
        
        launchSreenViewController.start(completion: {
            let navigationController = UINavigationController()
            let depengencyManager = DIContainer()
            self.appCoordinator = DefaultAppCoordinator(navigationController, depengencyManager)
            self.appCoordinator?.start()
            self.window?.rootViewController = navigationController
        })
    }

    func sceneDidDisconnect(_ scene: UIScene) {}

    func sceneDidBecomeActive(_ scene: UIScene) {}

    func sceneWillResignActive(_ scene: UIScene) {}

    func sceneWillEnterForeground(_ scene: UIScene) {}

    func sceneDidEnterBackground(_ scene: UIScene) {}
}
