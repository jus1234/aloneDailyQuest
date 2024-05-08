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
}
