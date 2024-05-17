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
    var childCoordinators: [Coordinator] = [Coordinator]()
    var type: CoordinatorCase { .ranking }
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    @MainActor func start() {
        showRankingViewController()
    }
    
    @MainActor func showRankingViewController() {
        let networkService = DefaultNetworkService()
        let repository = DefaultRankingRepository(networkService: networkService)
        let usecase = DefaultRankingUsecase(repository: repository)
        let viewModel = RankingViewModel(usecase: usecase, coordinator: self)
        let rankingViewContorller = RankingViewController(viewModel: viewModel)
        navigationController.pushViewController(rankingViewContorller, animated: false)
    }
    
    func finish(to nextCoordinator: CoordinatorCase) {
        finishDelegate?.didFinish(childCoordinator: self, to: nextCoordinator)
    }
}
