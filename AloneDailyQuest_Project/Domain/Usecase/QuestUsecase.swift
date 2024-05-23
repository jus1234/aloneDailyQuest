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
    func fetchUserInfo(userId: String) async throws -> UserInfo
    func fetchExperience(userId: String) async throws -> Int
    func addExperience(userId: String, experience: Int) async throws -> Int
    func updateDailyQuest() async throws
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
    
    func fetchUserInfo(userId: String) async throws -> UserInfo {
        return try await repository.fetchUserInfo(userId: userId)
    }
    
    func fetchExperience(userId: String) async throws -> Int {
        return try await repository.fetchExperience(userId: userId)
    }
    
    func addExperience(userId: String, experience: Int) async throws -> Int {
        return try await repository.addExperience(userId: userId, experience: experience)
    }
    
    func updateDailyQuest() async throws {
        if UserDefaults.standard.string(forKey: "lastVisitDate") == nil {
            UserDefaults.standard.setValue(Date().yesterdayString(with: DateFormatter.yyyyMMdd), forKey: "lastVisitDate")
        }
        guard let lastVisitDate = UserDefaults.standard.string(forKey: "lastVisitDate") else {
            return
        }
        if lastVisitDate != Date().toString(day: Date(), with: DateFormatter.yyyyMMdd) {
            try await repository.readQuest().forEach { quest in
                Task {
                    var newQuest = quest
                    newQuest.completed = false
                    try await repository.updateQuest(newQuestInfo: newQuest)
                    UserDefaults.standard.setValue(Date().toString(day: Date(), with: DateFormatter.yyyyMMdd), forKey: "lastVisitDate")
                }
            }
        }
        
    }
}
