//
//  QuestRepository.swift
//  AloneDailyQuest_Project
//
//  Created by Matthew on 5/8/24.
//

import Foundation

protocol QuestRepository {
    func createQuest(questInfo: QuestInfo) async throws
    func readQuest() async throws -> [QuestInfo]
    func updateQuest(newQuestInfo: QuestInfo) async throws
    func deleteQuest(questInfo: QuestInfo) async throws
    func repeatingQuestNewDay() async throws
    func fetchUserInfo(userId: String) async throws -> UserInfo
    func fetchExperience(userId: String) async throws -> Int
    func addExperience(userId: String, experience: Int) async throws -> Int
    func deleteQuests() async throws
}
