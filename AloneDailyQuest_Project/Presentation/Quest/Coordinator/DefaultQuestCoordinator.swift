//
//  DefaultQuestCoordinator.swift
//  AloneDailyQuest_Project
//
//  Created by Wooseok on 5/16/24.
//

import UIKit

final class DefaultQuestCoordinator: QuestCoordinator {
    weak var finishDelegate: CoordinatorFinishDelegate?
    var navigationController: UINavigationController
    var depengencyManager: DIContainer
    var childCoordinators: [Coordinator] = [Coordinator]()
    var type: CoordinatorCase { .quest }
    
    init(_ navigationController: UINavigationController, _ depengencyManager: DIContainer) {
        self.navigationController = navigationController
        self.depengencyManager = depengencyManager
    }
    
    @MainActor func start() {
        showQuestViewController()
    }
    
    @MainActor func showQuestViewController() {
        let videwModel = QuestViewModel(usecase: depengencyManager.makeQuestUsecase(), coordinator: self)
        let questViewController = QuestViewController(viewModel: videwModel)
        navigationController.pushViewController(questViewController, animated: false)
    }
    
    func finish(to nextCoordinator: CoordinatorCase) {
        finishDelegate?.didFinish(childCoordinator: self, to: nextCoordinator)
    }
}
