//
//  DefaultNoticeCoordinator.swift
//  AloneDailyQuest_Project
//
//  Created by Wooseok on 5/20/24.
//

import UIKit

final class DefaultNoticeCoordinator: NoticeCoordinator {
    var finishDelegate: CoordinatorFinishDelegate?
    var navigationController: UINavigationController
    var depengencyManager: DIContainer
    var childCoordinators: [Coordinator] = [Coordinator]()
    var type: CoordinatorCase { .notice }
    
    init(_ navigationController: UINavigationController, _ depengencyManager: DIContainer) {
        self.navigationController = navigationController
        self.depengencyManager = depengencyManager
    }
    
    @MainActor func start() {
        showNoticeViewContoroller()
    }
    
    @MainActor func showNoticeViewContoroller() {
        let viewModel = NoticeVewModel(coordinator: self)
        let noticeviewController = NoticeViewController(viewModel: viewModel)
        navigationController.pushViewController(noticeviewController, animated: true)
    }
    
    func finish(to nextCoordinator: CoordinatorCase) {
        finishDelegate?.didFinish(childCoordinator: self, to: nextCoordinator)
    }
}
