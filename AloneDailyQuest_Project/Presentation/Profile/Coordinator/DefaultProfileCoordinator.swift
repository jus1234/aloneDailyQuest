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
    var childCoordinators: [Coordinator] = [Coordinator]()
    var type: CoordinatorCase { .quest }
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    @MainActor func start() {
        showProfileViewController()
    }
    
    @MainActor func showProfileViewController() {
        let networkService = DefaultNetworkService()
        let repository = DefaultProfileRepository(networkService: networkService)
        let usecase = DefaultProfileUsecase(repository: repository)
        let videwModel = ProfileViewModel(usecase: usecase, coordinator: self)
        let questViewController = ProfileViewController(viewModel: videwModel)
        navigationController.pushViewController(questViewController, animated: false)
    }
    
    func finish(to nextCoordinator: CoordinatorCase) {
        finishDelegate?.didFinish(childCoordinator: self, to: nextCoordinator)
    }
}
