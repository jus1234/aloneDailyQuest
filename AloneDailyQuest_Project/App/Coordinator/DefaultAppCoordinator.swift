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
    var childCoordinators: [Coordinator] = [Coordinator]()
    var type: CoordinatorCase { .app }
    
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
        navigationController.setNavigationBarHidden(true, animated: false)
    }
    
    @MainActor func start() {
        guard let _ = UserDefaults.standard.string(forKey: "nickName") else {
            showSignupFlow()
            return
        }
        showQuestFlow()
    }
    
    @MainActor func showSignupFlow() {
        let signupCoordinator = DefaultSignupCoordinator(self.navigationController)
        signupCoordinator.finishDelegate = self
        signupCoordinator.start()
        childCoordinators.append(signupCoordinator)
    }
    
    @MainActor func showQuestFlow() {
        let questCoordinator = DefaultQuestCoordinator(self.navigationController)
        questCoordinator.finishDelegate = self
        questCoordinator.start()
        childCoordinators.append(questCoordinator)
    }
    
    @MainActor func showRankingFlow() {
        let rankingCoordinator = DefaultRankingCoordinator(self.navigationController)
        rankingCoordinator.finishDelegate = self
        rankingCoordinator.start()
        childCoordinators.append(rankingCoordinator)
    }
    
    @MainActor func showProfileFlow() {
        let profileCoordinator = DefaultProfileCoordinator(self.navigationController)
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
        }
    }
    
    
}
