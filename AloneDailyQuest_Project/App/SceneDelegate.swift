//
//  SceneDelegate.swift
//  AloneDailyQuest_Project
//
//  Created by Designer on 11/16/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate, delegateViewController {
    
    let coreManager = CoreDataManager.shared
    
    // 월요일부터0
    func currentDayOfWeek() -> Int {
        let today = Calendar.current.component(.weekday, from: Date())
        return (today + 5) % 7
    }
    
    func filterQuest() -> [QuestDataModel] {
        var quest = coreManager.getQuestListFromCoreData()
        return quest.filter{ $0.selectedDate[currentDayOfWeek()] || Calendar.current.component(.weekday, from:  $0.date) == Calendar.current.component(.weekday, from: Date()) }
    }
    
    func updateQuest(indexPath: Int) {
        let detailVC = DetailViewController()
        let selectedQuest = filterQuest()[indexPath]
        print(selectedQuest)
        detailVC.questData = selectedQuest
        detailVC.delegate = self
        window?.rootViewController = detailVC
        
    }
    
    func addQuest() {
        let detailVC = DetailViewController()
        detailVC.delegate = self
        window?.rootViewController = detailVC
        
    }
    
    func moveView() {
        let questListVC = QuestViewController()
        questListVC.coreManager = coreManager
        questListVC.delegate = self
        window?.rootViewController = questListVC
        window?.makeKeyAndVisible()
    }
    
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene) // SceneDelegate의 프로퍼티에 설정해줌
        
        // 프로필 뷰
        let mainViewController = LoginViewController()
        
        mainViewController.delegate = self
        
        window?.rootViewController = mainViewController
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.

        // Save changes in the application's managed object context when the application transitions to the background.
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }
}

protocol delegateViewController: AnyObject {
    func moveView()
    func addQuest()
    func updateQuest(indexPath: Int)
}
