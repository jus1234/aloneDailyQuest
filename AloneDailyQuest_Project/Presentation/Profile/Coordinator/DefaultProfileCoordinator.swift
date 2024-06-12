//
//  DefaultProfileCoordinator.swift
//  AloneDailyQuest_Project
//
//  Created by Matthew on 5/17/24.
//

import UIKit

final class DefaultProfileCoordinator: ProfileCoordinator {
    weak var finishDelegate: CoordinatorFinishDelegate?
    var navigationController: UINavigationController
    var depengencyManager: DIContainer
    var childCoordinators: [Coordinator] = [Coordinator]()
    var type: CoordinatorCase { .quest }
    
    init(_ navigationController: UINavigationController, _ depengencyManager: DIContainer) {
        self.navigationController = navigationController
        self.depengencyManager = depengencyManager
    }
    
    func start() {
        showProfileViewController()
    }
    
    func showProfileViewController() {
        let videwModel = ProfileViewModel(usecase: depengencyManager.makeProfileUsecase(), coordinator: self)
        let questViewController = ProfileViewController(viewModel: videwModel)
        navigationController.pushViewController(questViewController, animated: false)
    }
    
    func connectNoticeCoordinator() {
        let noticeCoordinator = DefaultNoticeCoordinator(self.navigationController, depengencyManager)
        noticeCoordinator.finishDelegate = self
        self.childCoordinators.append(noticeCoordinator)
        noticeCoordinator.start()
    }
    
    func finish(to nextCoordinator: CoordinatorCase) {
        finishDelegate?.didFinish(childCoordinator: self, to: nextCoordinator)
    }
}

extension DefaultProfileCoordinator: CoordinatorFinishDelegate {
    func didFinish(childCoordinator: Coordinator, to nextCoordinator: CoordinatorCase) {
        if nextCoordinator == .profile {
            self.childCoordinators = self.childCoordinators.filter { $0.type != childCoordinator.type }
            childCoordinator.navigationController.popToRootViewController(animated: true)
            return
        }
        finish(to: nextCoordinator)
    }
}
