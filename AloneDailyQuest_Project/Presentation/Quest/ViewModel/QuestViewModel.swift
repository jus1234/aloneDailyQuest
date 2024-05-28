//
//  QuestViewModel.swift
//  AloneDailyQuest_Project
//
//  Created by Matthew on 5/10/24.
//

import Foundation

@MainActor
final class QuestViewModel: ViewModel {
    struct Input {
        var viewWillAppear: Observable<Void>
        var deleteTrigger: Observable<QuestInfo?>
        var qeusetViewEvent: Observable<Void>
        var rankViewEvent: Observable<Void>
        var profileViewEvent: Observable<Void>
        var didPlusButtonTap: Observable<Void>
        var updateQuestEvent: Observable<QuestInfo>
        var completeQuestEvent: Observable<QuestInfo>
    }
    
    struct Output {
        var questList: Observable<[QuestInfo]>
        var errorMessage: Observable<String>
        var userInfo: Observable<UserInfo?>
    }
    
    private let usecase: QuestUsecase
    private let coordinator: QuestCoordinator
    private let questList: Observable<[QuestInfo]> = Observable([])
    private let errorMessage: Observable<String> = Observable("")
    private let user: Observable<UserInfo?> = Observable(nil)
    private var timer: Timer?

    
    init(usecase: QuestUsecase, coordinator: QuestCoordinator) {
        self.usecase = usecase
        self.coordinator = coordinator
        scheduleMidnightUpdate()
    }
    
    func transform(input: Input) -> Output {
        input.viewWillAppear.bind { [weak self] _ in
            self?.viewWillAppear()
        }
        input.updateQuestEvent.bind { [weak self] quest in
            self?.coordinator.connectDetailCoordinator(quest: quest)
        }
        input.deleteTrigger.bind { [weak self] quest in
            self?.deleteQuest(quest: quest!)
        }
        input.completeQuestEvent.bind { [weak self] quest in
            self?.updateQuest(quest: quest)
        }
        input.qeusetViewEvent.bind { _ in
            return
        }
        input.rankViewEvent.bind { [weak self] _ in
            self?.timer?.invalidate()
            self?.coordinator.finish(to: .ranking)
        }
        input.profileViewEvent.bind { [weak self] _ in
            self?.timer?.invalidate()
            self?.coordinator.finish(to: .profile)
        }
        input.didPlusButtonTap.bind { [weak self] _ in
            self?.timer?.invalidate()
            self?.coordinator.connectDetailCoordinator(quest: nil)
        }
        return .init(questList: self.questList,
                     errorMessage: self.errorMessage,
                     userInfo: self.user)
    }
    
    private func viewWillAppear() {
        Task {
            do {
                try await usecase.updateDailyQuest()
                try await fetchQuest()
            } catch {
                errorMessage.value = error.localizedDescription
            }
        }
    }
    
    func deleteQuest(quest: QuestInfo) {
        Task {
            do {
                try await usecase.deleteQuest(questInfo: quest)
                questList.value = try await usecase.readQuest()
            } catch {
                errorMessage.value = error.localizedDescription
            }
        }
    }
    
    func updateQuest(quest: QuestInfo) {
        Task {
            do {
                guard !usecase.isTodayExperienceAcquisitionMax() else {
                    errorMessage.value = "일일 최대 획득 경험치를 초과했습니다."
                    return
                }
                try await usecase.updateQuest(newQuestInfo: quest)
                questList.value = try await usecase.readQuest()
                try await updateExperience(experienceData: 1)
            } catch {
                errorMessage.value = error.localizedDescription
            }
        }
    }
    
    private func fetchUserInfo() {
        self.user.value = UserInfo(nickName: UserDefaults.standard.string(forKey: "nickName") ?? "",
                                   experience: UserDefaults.standard.integer(forKey: "experience"))
    }
    
    private func fetchQuest() async throws {
        questList.value = try await usecase.readQuest()
    }
    
    func updateExperience(experienceData: Int) async throws {
        let result = try await usecase.addExperience(userId: UserDefaults.standard.string(forKey: "nickName") ?? "", experience: experienceData)
        UserDefaults.standard.set(result, forKey: "experience")
        fetchUserInfo()
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
    
    @objc private func updateDailyQuest() {
        Task {
            try await usecase.updateDailyQuest()
            questList.value = try await usecase.readQuest()
        }
    }
}
