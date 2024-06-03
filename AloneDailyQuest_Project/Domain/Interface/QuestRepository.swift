//
//  QuestRepository.swift
//  AloneDailyQuest_Project
//
//  Created by Matthew on 5/8/24.
//

import Foundation
import RxSwift

protocol QuestRepository {
    func createQuest(questInfo: QuestInfo) async throws
    func readQuest() async throws -> [QuestInfo]
    func updateQuest(newQuestInfo: QuestInfo) async throws
    func deleteQuest(questInfo: QuestInfo) async throws
    func fetchUserInfo(userId: String) async throws -> UserInfo
    func fetchExperience(userId: String) async throws -> Int
    func addExperience(userId: String, experience: Int) async throws -> Int
    func deleteQuests() async throws
    func updateDailyQuest() async throws
    func create(quest: QuestInfo) -> Completable
    func fetchQuests() -> Single<[QuestInfo]>
    func update(quest: QuestInfo) -> Completable
    func delete(quest: QuestInfo) -> Completable
    func deleteQuests() -> Completable
    func fetchUserInfo(userId: String) -> Single<UserInfo>
    func fetchExperience(userId: String) -> Single<Int>
    func addExperience(userId: String, experience: Int) -> Single<Int>
    func resetDailyQuests() -> Completable
}
