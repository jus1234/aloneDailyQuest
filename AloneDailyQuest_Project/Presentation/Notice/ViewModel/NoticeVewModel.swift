//
//  NoticeVewModel.swift
//  AloneDailyQuest_Project
//
//  Created by Wooseok on 5/20/24.
//

import Foundation

@MainActor
final class NoticeVewModel: ViewModel {
    struct Input {
        var didBackButtonTap: Observable<Void>
        var qeusetViewEvent: Observable<Void>
        var rankViewEvent: Observable<Void>
        var profileViewEvent: Observable<Void>
    }
    
    struct Output {
        var errorMessage: Observable<String>
    }
    
    private let coordinator: NoticeCoordinator
    private var errorMessage: Observable<String> = Observable("")
    
    init(coordinator: NoticeCoordinator) {
        self.coordinator = coordinator
    }
    
    func transform(input: Input) -> Output {
        input.qeusetViewEvent.bind { [weak self] _ in
            self?.coordinator.finish(to: .quest)
        }
        input.rankViewEvent.bind { [weak self] _ in
            self?.coordinator.finish(to: .ranking)
        }
        input.profileViewEvent.bind { [weak self] _ in
            self?.coordinator.finish(to: .profile)
        }
        input.didBackButtonTap.bind { [weak self] _ in
            self?.coordinator.finish(to: .profile)
        }
        return Output(errorMessage: errorMessage)
    }
    
}
