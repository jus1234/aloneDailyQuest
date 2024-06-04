//
//  QuestRepository.swift
//  AloneDailyQuest_Project
//
//  Created by Matthew on 5/8/24.
//

import Foundation
import RxSwift

protocol QuestRepository {
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
