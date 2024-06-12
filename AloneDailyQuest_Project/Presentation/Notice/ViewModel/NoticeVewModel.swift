//
//  NoticeVewModel.swift
//  AloneDailyQuest_Project
//
//  Created by Wooseok on 5/20/24.
//

import Foundation

import RxSwift
import RxCocoa

final class NoticeVewModel: ViewModel {
    struct Input {
        var didBackButtonTap: ControlEvent<Void>
    }
    
    struct Output {
        var viewChangedEvent: Observable<Void>
    }
    
    private let coordinator: NoticeCoordinator
    
    init(coordinator: NoticeCoordinator) {
        self.coordinator = coordinator
    }
    
    func transform(input: Input) -> Output {
        let viewChangedEvent =  input.didBackButtonTap
            .do { [weak self] _ in
                self?.coordinator.finish(to: .profile)
            }
            .asObservable()
        
        return Output(viewChangedEvent: viewChangedEvent)
    }
    
}
