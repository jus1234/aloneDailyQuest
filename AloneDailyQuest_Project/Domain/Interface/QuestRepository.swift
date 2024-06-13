//
//  QuestRepository.swift
//  AloneDailyQuest_Project
//
//  Created by Matthew on 5/8/24.
//

import Foundation
import RxSwift

protocol QuestRepository {
    func create(quest: QuestInfo) -> Single<Bool>
    func fetchQuests() -> Single<[QuestInfo]>
    func update(quest: QuestInfo) -> Single<Bool>
    func delete(quest: QuestInfo) -> Single<Bool>
    func deleteQuests() -> Single<Void>
    func isExisting(quest: QuestInfo) -> Single<Bool>
    func fetchUserInfo(userId: String) -> Single<UserInfo>
    func fetchExperience(userId: String) -> Single<Int>
    func addExperience(userId: String, experience: Int) -> Single<Int>
    func resetDailyQuests() -> Completable
}
