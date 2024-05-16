//
//  CoordinatorFinishDelegate.swift
//  AloneDailyQuest_Project
//
//  Created by Wooseok on 5/16/24.
//

import Foundation

protocol CoordinatorFinishDelegate: AnyObject {

    func didFinish(childCoordinator: Coordinator, to nextCoordinator: CoordinatorCase)
}
