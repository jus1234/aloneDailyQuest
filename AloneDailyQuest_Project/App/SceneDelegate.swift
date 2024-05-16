//
//  SceneDelegate.swift
//  AloneDailyQuest_Project
//
//  Created by Designer on 11/16/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    // 월요일부터0
    func currentDayOfWeek() -> Int {
        let today = Calendar.current.component(.weekday, from: Date())
        return (today + 5) % 7
    }
    
//    func filterQuest() -> [QuestInfo] {
//        var quest
//        var quest = coreManager.getQuestListFromCoreData()
//        return quest.filter{ $0.selectedDate[currentDayOfWeek()] || Calendar.current.component(.weekday, from:  $0.date) == Calendar.current.component(.weekday, from: Date()) }
//    }
//    
//    func updateQuest(indexPath: Int) {
//        let detailVC = DetailViewController()
//        let selectedQuest = filterQuest()[indexPath]
//        detailVC.questData = selectedQuest
//        detailVC.delegate = self
//        window?.rootViewController = detailVC
//    }
//    
//    func addQuest() {
//        let detailVC = DetailViewController()
//        detailVC.delegate = self
//        window?.rootViewController = detailVC
//        
//    }
//    
//    func moveView() {
//        let questListVC = QuestViewController()
//        questListVC.coreManager = coreManager
//        questListVC.delegate = self
//        window?.rootViewController = questListVC
//        window?.makeKeyAndVisible()
//    }
    
    var window: UIWindow?
    var appCoordinator: AppCoordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let navigationController = UINavigationController()
        appCoordinator = DefaultAppCoordinator(navigationController)
        appCoordinator?.start()
        window = UIWindow(windowScene: windowScene)
        self.window?.rootViewController = navigationController
    }

    func sceneDidDisconnect(_ scene: UIScene) {}

    func sceneDidBecomeActive(_ scene: UIScene) {}

    func sceneWillResignActive(_ scene: UIScene) {}

    func sceneWillEnterForeground(_ scene: UIScene) {}

    func sceneDidEnterBackground(_ scene: UIScene) {}
}
