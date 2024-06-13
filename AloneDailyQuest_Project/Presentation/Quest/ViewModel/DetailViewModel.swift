//
//  DetailViewModel.swift
//  AloneDailyQuest_Project
//
//  Created by Matthew on 5/10/24.
//

import Foundation

import RxSwift
import RxCocoa

final class DetailViewModel: ViewModel {
    struct Input {
        var saveQuest: Observable<QuestInfo?>
        var didBackButtonTapEvent: ControlEvent<Void>
    }
    
    struct Output {
        var saveResult: Observable<Bool>
        var viewChanged: Observable<Void>
    }
    
    private let usecase: QuestUsecase
    private let coordinator: DetailCoordinator
    
    init(usecase: QuestUsecase, coordinator: DetailCoordinator) {
        self.usecase = usecase
        self.coordinator = coordinator
    }
    
    func transform(input: Input) -> Output {
        let saveResult = input.saveQuest
            .flatMap { [weak self] quest -> Single<Bool> in
                guard let quest else {
                    return .just(false)
                }
                guard let saveResult = self?.usecase.save(quest: quest) else {
                    return .just(false)
                }
                return saveResult
            }
            .do(onNext: { [weak self] result in
                if result {
                    self?.coordinator.finish(to: .quest)
                }
            })
            .asObservable()
        
        let viewChanged =  input.didBackButtonTapEvent
            .do(onNext: { [weak self] _ in
                self?.coordinator.finish(to: .quest)
            })
            .asObservable()
        
        return Output(saveResult: saveResult, viewChanged: viewChanged)
    }
    
}
