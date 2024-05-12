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
    func fetchUserInfo(userId: String) async throws -> UserInfo
    func fetchExperience(userId: String) async throws -> Int
    func addExperience(user: UserInfo) async throws -> Int
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
    
    func fetchUserInfo(userId: String) async throws -> UserInfo {
        return try await repository.fetchUserInfo(userId: userId)
    }
    
    func fetchExperience(userId: String) async throws -> Int {
        return try await repository.fetchExperience(userId: userId)
    }
    
    func addExperience(user: UserInfo) async throws -> Int {
        return try await repository.addExperience(user: user)
    }
}
