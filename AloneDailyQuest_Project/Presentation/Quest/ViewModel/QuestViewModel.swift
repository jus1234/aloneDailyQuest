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
        var viewDidLoad: Observable<Void>
        var deleteTrigger: Observable<QuestInfo?>
        var experienceTrigger: Observable<Int>
        var qeusetViewEvent: Observable<Void>
        var rankViewEvent: Observable<Void>
        var profileViewEvent: Observable<Void>
        var didPlusButtonTap: Observable<Void>
        var updateQuestEvent: Observable<QuestInfo>
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
    
    init(usecase: QuestUsecase, coordinator: QuestCoordinator) {
        self.usecase = usecase
        self.coordinator = coordinator
    }
    
    private func viewDidLoad() {
        Task {
            await fetchQuest()
            checkUserDefaultsLastVisitDate()
            await checkUserDefaultsDeleteData()
            fetchUserInfo()
        }
    }
    
    private func fetchUserInfo() {
        self.user.value = UserInfo(nickName: UserDefaults.standard.string(forKey: "nickName") ?? "",
                                   experience: UserDefaults.standard.integer(forKey: "experience"))
    }
    
    private func fetchQuest() async {
        Task {
            do {
                try await usecase.repeatingQuestNewDay()
                questList.value = try await usecase.readQuest()
            } catch {
                errorMessage.value = error.localizedDescription
            }
        }
    }
    
    private func checkUserDefaultsLastVisitDate() {
        if UserDefaults.standard.object(forKey: "lastVisitDate") == nil {
            UserDefaults.standard.set(Date(), forKey: "lastVisitDate")
        }
    }
    
    private func checkUserDefaultsDeleteData() async {
        let currentDate = Date()
        let calendar = Calendar.current
        let lastVisitDate = UserDefaults.standard.object(forKey: "lastVisitDate") as? Date ?? currentDate
        
        if calendar.isDate(lastVisitDate, inSameDayAs: currentDate) == false {
            do {
                try await usecase.repeatingQuestNewDay()
                UserDefaults.standard.set(currentDate, forKey: "lastVisitDate")
            } catch {
                errorMessage.value = error.localizedDescription
            }
        }
    }
    
    func deleteQuest(quest: QuestInfo) {
        Task {
            do {
                try await usecase.deleteQuest(questInfo: quest)
            } catch {
                errorMessage.value = error.localizedDescription
            }
        }
    }
    
    func updateQuest(quest: QuestInfo) {
        Task {
            do {
                try await usecase.updateQuest(newQuestInfo: quest)
            } catch {
                errorMessage.value = error.localizedDescription
            }
        }
    }
    
    func updateExperience(experienceData: Int) {
        Task {
            do {
                let result = try await usecase.addExperience(userId: UserDefaults.standard.string(forKey: "nickName") ?? "",
                                                             experience: experienceData)
                UserDefaults.standard.set(result, forKey: "experience")
            } catch {
                errorMessage.value = error.localizedDescription
            }
        }
    }
    
    func transform(input: Input) -> Output {
        input.viewDidLoad.bind { _ in
            self.viewDidLoad()
        }
        
        input.deleteTrigger.bind { quest in
            self.deleteQuest(quest: quest!)
            self.viewDidLoad()
        }
        
        input.experienceTrigger.bind { experience in
            self.updateExperience(experienceData: experience)
            self.viewDidLoad()
        }
        input.qeusetViewEvent.bind { _ in
            return
        }
        input.rankViewEvent.bind { [weak self] _ in
            self?.coordinator.finish(to: .ranking)
        }
        input.profileViewEvent.bind { [weak self] _ in
            self?.coordinator.finish(to: .profile)
        }
        input.didPlusButtonTap.bind { [weak self] _ in
            self?.coordinator.connectDetailCoordinator(quest: nil)
        }
        return .init(questList: self.questList,
                     errorMessage: self.errorMessage,
                     userInfo: self.user)
    }
}
