//
//  QuestUsecase.swift
//  AloneDailyQuest_Project
//
//  Created by Matthew on 5/8/24.
//

import Foundation

protocol QuestUsecase {
    func createQuest(questInfo: QuestInfo) async throws
    func readQuest() async throws -> [QuestInfo]
    func updateQuest(newQuestInfo: QuestInfo) async throws
    func deleteQuest(questInfo: QuestInfo) async throws
    func repeatingQuestNewDay() async throws
}

final class DefaultQuestUsecase: QuestUsecase {
    private let repository: QuestRepository
    
    init(repository: QuestRepository) {
        self.repository = repository
    }
    
    func createQuest(questInfo: QuestInfo) async throws {
        try await repository.createQuest(questInfo: questInfo)
    }
    
    func readQuest() async throws -> [QuestInfo] {
        return try await repository.readQuest()
    }
    
    func updateQuest(newQuestInfo: QuestInfo) async throws {
        try await repository.updateQuest(newQuestInfo: newQuestInfo)
    }
    
    func deleteQuest(questInfo: QuestInfo) async throws {
        try await repository.deleteQuest(questInfo: questInfo)
    }
    
    func repeatingQuestNewDay() async throws {
        try await repository.repeatingQuestNewDay()
    }
}
