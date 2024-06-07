//
//  DefaultAppCoordinator.swift
//  AloneDailyQuest_Project
//
//  Created by Wooseok on 5/16/24.
//

import UIKit

final class DefaultAppCoordinator: AppCoordinator {
    weak var finishDelegate: CoordinatorFinishDelegate?
    var navigationController: UINavigationController
    var depengencyManager: DIContainer
    var childCoordinators: [Coordinator] = [Coordinator]()
    var type: CoordinatorCase { .app }
    
    required init(_ navigationController: UINavigationController, _ depengencyManager: DIContainer) {
        self.navigationController = navigationController
        self.depengencyManager = depengencyManager
        navigationController.setNavigationBarHidden(true, animated: false)
    }
    
    func start() {
        guard let _ = UserDefaults.standard.string(forKey: "nickName") else {
            showSignupFlow()
            return
        }
        showQuestFlow()
    }
    
    func showSignupFlow() {
        let signupCoordinator = DefaultSignupCoordinator(self.navigationController, self.depengencyManager)
        signupCoordinator.finishDelegate = self
        signupCoordinator.start()
        childCoordinators.append(signupCoordinator)
    }
    
    func showQuestFlow() {
        let questCoordinator = DefaultQuestCoordinator(self.navigationController, self.depengencyManager)
        questCoordinator.finishDelegate = self
        questCoordinator.start()
        childCoordinators.append(questCoordinator)
    }
    
    func showRankingFlow() {
        let rankingCoordinator = DefaultRankingCoordinator(self.navigationController, self.depengencyManager)
        rankingCoordinator.finishDelegate = self
        rankingCoordinator.start()
        childCoordinators.append(rankingCoordinator)
    }
    
    @MainActor func showProfileFlow() {
        let profileCoordinator = DefaultProfileCoordinator(self.navigationController, self.depengencyManager)
        profileCoordinator.finishDelegate = self
        profileCoordinator.start()
        childCoordinators.append(profileCoordinator)
    }
}

extension DefaultAppCoordinator: CoordinatorFinishDelegate {
    @MainActor func didFinish(childCoordinator: Coordinator, to nextCoordinator: CoordinatorCase) {
        self.childCoordinators = self.childCoordinators.filter({ $0.type != childCoordinator.type })
        self.navigationController.viewControllers.removeAll()
        
        switch nextCoordinator {
        case .app:
            self.start()
        case .signup:
            self.showSignupFlow()
        case .quest:
            self.showQuestFlow()
        case .ranking:
            showRankingFlow()
        case .profile:
            showProfileFlow()
        default:
            break
        }
    }
    
    
}
