//
//  QuestViewModel.swift
//  AloneDailyQuest_Project
//
//  Created by wooseok on 6/13/24.
//

import Foundation

import RxSwift
import RxCocoa

final class QuestViewModel: ViewModel {
    struct Input {
        var viewWillAppear: ControlEvent<Bool>
        var loadQuests: PublishRelay<Void>
        var deleteQuest: PublishRelay<QuestInfo>
        var moveToRankView: ControlEvent<Void>
        var moveToProfileView: ControlEvent<Void>
        var createQuest: ControlEvent<Void>
        var updateQuest: PublishRelay<QuestInfo>
        var completeQuest: PublishRelay<QuestInfo>
        var dayChanged: Observable<Notification>
    }
    
    struct Output {
        var quests: Observable<[QuestInfo]>
        var updateResult: Observable<Bool>
        var delereResult: Observable<Void>
        var viewChanged: Observable<Void>
        var resetDailyQuests: Observable<Void>
    }
    
    private let usecase: QuestUsecase
    private let coordinator: QuestCoordinator
    
    init(usecase: QuestUsecase, coordinator: QuestCoordinator) {
        self.usecase = usecase
        self.coordinator = coordinator
    }
    
    func transform(input: Input) -> Output {
        let viewWillAppear = input.viewWillAppear
            .map { _ in}
            .asObservable()
        
        let dayChanged = input.dayChanged
            .map { _ in}
            .asObservable()
        
        let resetDailyQuests = Observable.merge([viewWillAppear, dayChanged])
            .flatMap { [weak self] _ -> Single<Void> in
                guard let resetDailyQuests = self?.usecase.resetDailyQuests() else {
                    return .error(NSError())
                }
                return resetDailyQuests
            }
            .asObservable()
        
        let quests = input.loadQuests
            .flatMap { [weak self] _ -> Observable<[QuestInfo]> in
                guard let quests = self?.usecase.fetchQuests().asObservable() else {
                    return .empty()
                }
                return quests
            }
        
        let updateResult = input.completeQuest
            .flatMap { [weak self] quest -> Single<Bool> in
                guard let result = self?.usecase.complete(quest: quest) else {
                    return .error(NSError())
                }
                return result
            }
            .asObservable()
        
        let deleteResult = input.deleteQuest
            .flatMap { [weak self] quest -> Single<Bool> in
                guard let result = self?.usecase.delete(quest: quest) else {
                    return .error(NSError())
                }
                return result
            }
            .map { _ in return }
            .asObservable()
        
        let toDetailToCreate = input.createQuest
            .do(onNext: { [weak self] _ in
                self?.coordinator.connectDetailCoordinator(quest: nil)
            })
        
        let toDetailToUpdate = input.updateQuest
            .do(onNext: { [weak self] quest in
                self?.coordinator.connectDetailCoordinator(quest: quest)
            })
            .map { _ in }
        
        let toRanking = input.moveToRankView
            .do(onNext: { [weak self] _ in
                self?.coordinator.finish(to: .ranking)
            })
        
        let toProfile = input.moveToProfileView
            .do(onNext: {[weak self] _ in
                self?.coordinator.finish(to: .profile)
            })
        
        let viewChanged = Observable.merge(
            [toDetailToCreate, toDetailToUpdate, toRanking, toProfile])
        
        return Output(
            quests: quests,
            updateResult: updateResult,
            delereResult: deleteResult,
            viewChanged: viewChanged,
            resetDailyQuests: resetDailyQuests)
    }
}
