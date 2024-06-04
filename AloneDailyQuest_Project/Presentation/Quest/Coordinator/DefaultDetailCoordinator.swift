//
//  DefaultDetailCoordinator.swift
//  AloneDailyQuest_Project
//
//  Created by Wooseok on 5/20/24.
//

import UIKit

final class DefaultDetailCoordinator: DetailCoordinator {
    var finishDelegate: CoordinatorFinishDelegate?
    var navigationController: UINavigationController
    var depengencyManager: DIContainer
    var childCoordinators: [Coordinator] = [Coordinator]()
    var type: CoordinatorCase { .detail }
    
    init(_ navigationController: UINavigationController, _ depengencyManager: DIContainer) {
        self.navigationController = navigationController
        self.depengencyManager = depengencyManager
    }
    
    func start() {}
    
    func start(quest: QuestInfo?) {
        showDetailViewContorller(quest: quest)
    }
    
    func showDetailViewContorller(quest: QuestInfo?) {
        let detailViewModel = DetailViewModel(usecase: depengencyManager.makeQuestUsecase(),
                                              coordinator: self)
        let detailViewController = DetailViewController(viewModel: detailViewModel, questData: quest)
        navigationController.pushViewController(detailViewController, animated: true)
    }
    
    func finish(to nextCoordinator: CoordinatorCase) {
        finishDelegate?.didFinish(childCoordinator: self, to: nextCoordinator)
    }
}
