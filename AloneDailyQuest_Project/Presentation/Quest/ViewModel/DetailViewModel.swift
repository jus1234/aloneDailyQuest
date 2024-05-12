//
//  DetailViewModel.swift
//  AloneDailyQuest_Project
//
//  Created by Matthew on 5/10/24.
//

import Foundation

final class DetailViewModel: ViewModel {
    struct Input {
        var viewDidLoad: Observable<Void>
        var updateTrigger: Observable<QuestInfo>
        var addTrigger: Observable<QuestInfo>
    }
    
    struct Output {
        var errorMessage: Observable<String>
    }
    
    private let usecase: QuestUsecase
    private var quest: Observable<QuestInfo>
    private let errorMessage: Observable<String> = Observable("")
    
    init(usecase: QuestUsecase, quest: QuestInfo) {
        self.usecase = usecase
        self.quest = Observable(quest)
    }
    
    private func fetchQuest() async {
        Task {
            do {
                let coreQuests = try await self.usecase.readQuest()
                for quest in coreQuests {
                    if self.quest.value.id == quest.id {
                        self.quest.value = quest
                    }
                }
            } catch {
                errorMessage.value = error.localizedDescription
            }
        }
    }
    
    private func viewDidLoad() {
        Task {
            await fetchQuest()
        }
    }
    
    private func coreDataCreate(quest: QuestInfo) async {
        Task {
            do {
                try await self.usecase.createQuest(questInfo: quest)
            } catch {
                errorMessage.value = error.localizedDescription
            }
        }
    }
    
    private func createQuest(quest: QuestInfo) {
        Task {
            await coreDataCreate(quest: quest)
        }
    }
    
    private func coreDataUpdate(newQuest: QuestInfo) async {
        Task {
            do {
                try await self.usecase.updateQuest(newQuestInfo: newQuest)
            } catch {
                errorMessage.value = error.localizedDescription
            }
        }
    }
    
    private func updateQuest(newQuest: QuestInfo) {
        Task {
            await coreDataUpdate(newQuest: newQuest)
        }
    }
    
    func transform(input: Input) -> Output {
        input.viewDidLoad.bind { _ in
            self.viewDidLoad()
        }
        
        input.updateTrigger.bind { quest in
            self.updateQuest(newQuest: quest)
        }
        
        input.addTrigger.bind { quest in
            self.createQuest(quest: quest)
        }
        
        return Output(errorMessage: self.errorMessage)
    }
}
