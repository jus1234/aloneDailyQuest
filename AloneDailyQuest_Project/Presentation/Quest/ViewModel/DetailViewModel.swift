//
//  DetailViewModel.swift
//  AloneDailyQuest_Project
//
//  Created by Matthew on 5/10/24.
//

import Foundation

@MainActor
final class DetailViewModel: ViewModel {
    struct Input {
        var viewDidLoad: Observable<Void>
        var updateTrigger: Observable<QuestInfo?>
        var addTrigger: Observable<QuestInfo?>
    }
    
    struct Output {
        var errorMessage: Observable<String>
        var userInfo: Observable<UserInfo?>
    }
    
    private let usecase: QuestUsecase
    private let coordinator: DetailCoordinator
    private var quest: Observable<QuestInfo?>
    private let errorMessage: Observable<String> = Observable("")
    private let user: Observable<UserInfo?> = Observable(nil)
    
    init(usecase: QuestUsecase, coordinator: DetailCoordinator, quest: QuestInfo?) {
        self.usecase = usecase
        self.coordinator = coordinator
        self.quest = Observable(quest)
    }
    
    private func fetchQuest() async throws {
        let coreQuests = try await self.usecase.readQuest()
        for coreQuest in coreQuests {
            if let quest = self.quest.value, quest.id == coreQuest.id {
                self.quest.value = quest
            }
        }
    }
    
    private func fetchUserInfo() {
        self.user.value = UserInfo(nickName: UserDefaults.standard.string(forKey: "nickName") ?? "",
                                   experience: UserDefaults.standard.integer(forKey: "experience"))
    }
    
    private func viewDidLoad() {
        Task {
            do {
                try await fetchQuest()
                fetchUserInfo()
            } catch {
                errorMessage.value = error.localizedDescription
            }
        }
    }
    
    private func coreDataCreate(quest: QuestInfo) async throws {
        try await self.usecase.createQuest(questInfo: quest)
    }
    
    private func createQuest(quest: QuestInfo) {
        Task {
            do {
                try await coreDataCreate(quest: quest)
                coordinator.finish(to: .quest)
            } catch {
                errorMessage.value = error.localizedDescription
            }
        }
    }
    
    private func coreDataUpdate(newQuest: QuestInfo) async throws {
        try await self.usecase.updateQuest(newQuestInfo: newQuest)
    }
    
    private func updateQuest(newQuest: QuestInfo) {
        Task {
            do {
                try await coreDataUpdate(newQuest: newQuest)
                coordinator.finish(to: .quest)
            } catch {
                errorMessage.value = error.localizedDescription
            }
        }
    }
    
    func transform(input: Input) -> Output {
        input.viewDidLoad.bind { _ in
            self.viewDidLoad()
        }
        
        input.updateTrigger.bind { quest in
            guard let quest else {
                return
            }
            self.updateQuest(newQuest: quest)
        }
        
        input.addTrigger.bind { quest in
            guard let quest else {
                return
            }
            self.createQuest(quest: quest)
        }
        
        return Output(errorMessage: self.errorMessage,
                      userInfo: self.user)
    }
}
