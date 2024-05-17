//
//  DefaultSignupCoordinator.swift
//  AloneDailyQuest_Project
//
//  Created by Wooseok on 5/16/24.
//

import UIKit

final class DefaultSignupCoordinator: SignupCoordinator {
    weak var finishDelegate: CoordinatorFinishDelegate?
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = [Coordinator]()
    var type: CoordinatorCase { .signup }
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    @MainActor func start() {
        showSignupViewController()
    }
    
    @MainActor func showSignupViewController() {
        let networkService = DefaultNetworkService()
        let repository = DefaultAccountRepository(networkService: networkService)
        let usecase = DefaultAccountUsecase(repository: repository)
        let viewModel = SignupViewModel(usecase: usecase, coordinator: self)
        let signupViewController = SignupViewController(viewModel: viewModel)
        navigationController.pushViewController(signupViewController, animated: false)
    }
    
    func finish() {
        finishDelegate?.didFinish(childCoordinator: self, to: .quest)
    }
}
