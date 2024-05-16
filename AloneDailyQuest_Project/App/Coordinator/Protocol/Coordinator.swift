//
//  Coordinator.swift
//  AloneDailyQuest_Project
//
//  Created by Wooseok on 5/13/24.
//

import UIKit

protocol Coordinator: AnyObject  {
    var finishDelegate: CoordinatorFinishDelegate? { get set }
    var navigationController: UINavigationController { get set }
    var childCoordinators: [Coordinator] { get set }
    var type: CoordinatorCase { get }
    
    func start()
    func finish(to nextCoordinator: CoordinatorCase)
    
    init(_ navigationController: UINavigationController)
}

extension Coordinator {
    func finish(to nextCoordinator: CoordinatorCase) {
        childCoordinators.removeAll()
        finishDelegate?.didFinish(childCoordinator: self, to: nextCoordinator)
    }
}
