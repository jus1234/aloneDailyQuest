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
    var depengencyManager: DIContainer
    var childCoordinators: [Coordinator] = [Coordinator]()
    var type: CoordinatorCase { .signup }
    
    init(_ navigationController: UINavigationController, _ depengencyManager: DIContainer) {
        self.navigationController = navigationController
        self.depengencyManager = depengencyManager
    }
    
    func start() {
        showSignupViewController()
    }
    
    func showSignupViewController() {
        let viewModel = SignupViewModel(usecase: depengencyManager.makeAccountUsecase(), coordinator: self)
        let signupViewController = SignupViewController(viewModel: viewModel)
        navigationController.pushViewController(signupViewController, animated: false)
    }
    
    @MainActor func finish() {
        finishDelegate?.didFinish(childCoordinator: self, to: .quest)
    }
}
