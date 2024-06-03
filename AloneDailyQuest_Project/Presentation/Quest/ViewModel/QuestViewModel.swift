//
//  QuestViewModel.swift
//  AloneDailyQuest_Project
//
//  Created by Matthew on 5/10/24.
//

import Foundation

import RxSwift
import RxCocoa

final class QuestViewModel: ViewModel {
    private var disposeBag = DisposeBag()
    
    struct Input {
        var viewWillAppear: ControlEvent<Bool>
        var deleteQuestEvent: PublishRelay<QuestInfo?>
        var qeusetViewEvent: ControlEvent<Void>
        var rankViewEvent: ControlEvent<Void>
        var profileViewEvent: ControlEvent<Void>
        var didPlusButtonTap: ControlEvent<Void>
        var updateQuestEvent: PublishRelay<QuestInfo>
        var completeQuestEvent: PublishRelay<QuestInfo>
    }
    
    struct Output {
        var questList: PublishRelay<[QuestInfo]>
        var errorMessage: PublishRelay<String>
        var userInfo: PublishRelay<UserInfo?>
    }
    
    private let usecase: QuestUsecase
    private let coordinator: QuestCoordinator
    
    private let output = Output(
        questList: PublishRelay(),
        errorMessage: PublishRelay(),
        userInfo: PublishRelay())
    
    init(usecase: QuestUsecase, coordinator: QuestCoordinator) {
        self.usecase = usecase
        self.coordinator = coordinator
        scheduleMidnightUpdate()
    }
    
    func transform(input: Input) -> Output {
        input.viewWillAppear
            .flatMap { [weak self] _ -> Single<([QuestInfo], Void)> in
                guard let self else {
                    return Single.error(NSError())
                }
                return Single.zip(usecase.fetchQuests(), usecase.resetDailyQuests())
            }
            .subscribe(onNext: { quests, _ in
                self.output.questList.accept(quests)
            }, onError: { [weak self] _ in
                self?.output.errorMessage.accept("처리 중 문제가 발생했습니다.")
            })
            .disposed(by: disposeBag)
        
        input.deleteQuestEvent
            .subscribe(onNext: { [weak self] quest in
                guard let quest else {
                    return
                }
                self?.delete(quest: quest)
                self?.fetchQuests()
            })
            .disposed(by: disposeBag)
        
        input.updateQuestEvent
            .subscribe(onNext: { [weak self] quest in
                self?.coordinator.connectDetailCoordinator(quest: quest)
            })
            .disposed(by: disposeBag)
        
        input.completeQuestEvent
            .flatMapLatest { [weak self] quest -> Single<(Void, QuestInfo)> in
                guard let self else {
                    return Single.error(NSError())
                }
                return Single.zip(usecase.isTodayExperienceAcquisitionMax(), Single.just(quest))
            }
            .subscribe(onNext: { [weak self] _, quest in
                guard let nickName = UserDefaults.standard.string(forKey: "nickName") else {
                    return
                }
                self?.update(quest: quest)
                self?.addExperience(nickName: nickName)
                self?.fetchQuests()
            }, onError: { _ in
                self.output.errorMessage.accept("일일 최대 획득 경험치를 초과했습니다.")
            })
            .disposed(by: disposeBag)
        
        input.rankViewEvent
            .subscribe(onNext: { [weak self] _ in
                self?.coordinator.finish(to: .ranking)
            })
            .disposed(by: disposeBag)
        
        input.profileViewEvent
            .subscribe(onNext: { [weak self] _ in
                self?.coordinator.finish(to: .profile)
            })
            .disposed(by: disposeBag)
        
        input.didPlusButtonTap
            .subscribe(onNext: { [weak self] _ in
                self?.coordinator.connectDetailCoordinator(quest: nil)
            })
            .disposed(by: disposeBag)
        
        return output
    }
    
    private func fetchQuests() {
        usecase.fetchQuests()
            .subscribe(onSuccess: { [weak self] quests in
                self?.output.questList.accept(quests)
            })
            .disposed(by: disposeBag)
    }
    
    private func update(quest: QuestInfo) {
        usecase.update(quest: quest)
            .subscribe( onError: { error in
                self.output.errorMessage.accept(error.localizedDescription)
            })
            .disposed(by: disposeBag)
    }
    
    private func addExperience(nickName: String) {
        usecase.addExperience(userId: nickName, experience: 1)
            .subscribe(onSuccess: { experience in
                UserDefaults.standard.set(experience, forKey: "experience")
                self.output.userInfo.accept(UserInfo(nickName: nickName, experience: experience))
            }, onFailure: { error in
                self.output.errorMessage.accept(error.localizedDescription)
            })
            .disposed(by: disposeBag)
    }
    
    private func delete(quest: QuestInfo) {
        usecase.delete(quest: quest)
            .subscribe(onError: { [weak self] _ in
                self?.output.errorMessage.accept("퀘스트 삭제를 실패했습니다.")
            })
            .disposed(by: disposeBag)
    }
}

extension QuestViewModel {
    private func scheduleMidnightUpdate() {
        let now = Date()
        let calendar = Calendar.current
        guard let midnight = calendar.nextDate(after: now, matching: DateComponents(hour: 0, minute: 0, second: 0), matchingPolicy: .nextTime) else {
            return
        }
        let timeInterval = midnight.timeIntervalSince(now)
        DispatchQueue.main.asyncAfter(deadline: .now() + timeInterval) {
            self.updateDailyQuest()
        }
        
    }
    
    private func updateDailyQuest() {
        Single.zip(usecase.resetDailyQuests(), usecase.fetchQuests())
            .subscribe(onSuccess: { [weak self] _, quests in
                self?.output.questList.accept(quests)
            }, onFailure: { [weak self] _ in
                self?.output.errorMessage.accept("처리 중 문제가 발생했습니다.")
            })
            .disposed(by: disposeBag)
    }
}
