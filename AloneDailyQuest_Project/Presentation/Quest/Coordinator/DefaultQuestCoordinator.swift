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
    var childCoordinators: [Coordinator] = [Coordinator]()
    var type: CoordinatorCase { .quest }
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    @MainActor func start() {
        showQuestViewController()
    }
    
    @MainActor func showQuestViewController() {
        let networkService = DefaultNetworkService()
        let repository = DefaultQuestRepository(networkService: networkService)
        let usecase = DefaultQuestUsecase(repository: repository)
        let videwModel = QuestViewModel(usecase: usecase)
        let questViewController = QuestViewController(viewModel: videwModel)
        navigationController.pushViewController(questViewController, animated: true)
    }
    
    func finish(to nextCoordinator: CoordinatorCase) {
        finishDelegate?.didFinish(childCoordinator: self, to: nextCoordinator)
    }
}
