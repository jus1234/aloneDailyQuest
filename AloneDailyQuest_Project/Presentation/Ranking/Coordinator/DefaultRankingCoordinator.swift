//
//  DefaultRankingCoordinator.swift
//  AloneDailyQuest_Project
//
//  Created by Wooseok on 5/16/24.
//

import UIKit

final class DefaultRankingCoordinator: RankingCoordinator {
    var finishDelegate: CoordinatorFinishDelegate?
    var navigationController: UINavigationController
    var depengencyManager: DIContainer
    var childCoordinators: [Coordinator] = [Coordinator]()
    var type: CoordinatorCase { .ranking }
    
    init(_ navigationController: UINavigationController, _ depengencyManager: DIContainer) {
        self.navigationController = navigationController
        self.depengencyManager = depengencyManager
    }
    
    func start() {
        showRankingViewController()
    }
    
    func showRankingViewController() {
        let viewModel = RankingViewModel(usecase: depengencyManager.makeRnakingUsecase(), coordinator: self)
        let rankingViewContorller = RankingViewController(viewModel: viewModel)
        navigationController.pushViewController(rankingViewContorller, animated: false)
    }
    
    func finish(to nextCoordinator: CoordinatorCase) {
        finishDelegate?.didFinish(childCoordinator: self, to: nextCoordinator)
    }
}
