//
//  QuestUsecase.swift
//  AloneDailyQuest_Project
//
//  Created by Matthew on 5/8/24.
//

import Foundation
import RxSwift

protocol QuestUsecase {
    func createQuest(questInfo: QuestInfo) async throws
    func readQuest() async throws -> [QuestInfo]
    func updateQuest(newQuestInfo: QuestInfo) async throws
    func deleteQuest(questInfo: QuestInfo) async throws
    func fetchUserInfo(userId: String) async throws -> UserInfo
    func fetchExperience(userId: String) async throws -> Int
    func addExperience(userId: String, experience: Int) async throws -> Int
    func updateDailyQuest() async throws
    func isTodayExperienceAcquisitionMax() -> Bool
    func create(quest: QuestInfo) -> Completable
    func fetchQuests() -> Single<[QuestInfo]>
    func update(quest: QuestInfo) -> Completable
    func delete(quest: QuestInfo) -> Completable
    func fetchUserInfo(userId: String) -> Single<UserInfo>
    func fetchExperience(userId: String) -> Single<Int>
    func addExperience(userId: String, experience: Int) -> Single<Int>
    func resetDailyQuests() -> Single<Void>
    func isTodayExperienceAcquisitionMax() -> Single<Void>
}

final class DefaultQuestUsecase: QuestUsecase {
    private let repository: QuestRepository
    
    init(repository: QuestRepository) {
        self.repository = repository
    }
    
    func createQuest(questInfo: QuestInfo) async throws {
        try await repository.createQuest(questInfo: questInfo)
    }
    
    func create(quest: QuestInfo) -> Completable {
        return repository.create(quest: quest)
    }
    
    func readQuest() async throws -> [QuestInfo] {
        return try await repository.readQuest()
    }
    
    func fetchQuests() -> Single<[QuestInfo]> {
        return repository.fetchQuests()
    }
    
    func updateQuest(newQuestInfo: QuestInfo) async throws {
        try await repository.updateQuest(newQuestInfo: newQuestInfo)
    }
    
    func update(quest: QuestInfo) -> Completable {
        return repository.update(quest: quest)
    }
    
    func deleteQuest(questInfo: QuestInfo) async throws {
        try await repository.deleteQuest(questInfo: questInfo)
    }
    
    func delete(quest: QuestInfo) -> Completable {
        return repository.delete(quest: quest)
    }
    
    func fetchUserInfo(userId: String) async throws -> UserInfo {
        return try await repository.fetchUserInfo(userId: userId)
    }
    
    func fetchUserInfo(userId: String) -> Single<UserInfo> {
        return repository.fetchUserInfo(userId: userId)
    }
    
    func fetchExperience(userId: String) async throws -> Int {
        return try await repository.fetchExperience(userId: userId)
    }
    
    func fetchExperience(userId: String) -> Single<Int> {
        return repository.fetchExperience(userId: userId)
    }
    
    func addExperience(userId: String, experience: Int) async throws -> Int {
        return try await repository.addExperience(userId: userId, experience: experience)
    }
    
    func addExperience(userId: String, experience: Int) -> Single<Int> {
        return repository.addExperience(userId: userId, experience: experience)
    }
    
    func updateDailyQuest() async throws {
        if UserDefaults.standard.string(forKey: "lastVisitDate") == nil {
            UserDefaults.standard.setValue(Date().yesterdayString(with: DateFormatter.yyyyMMdd), forKey: "lastVisitDate")
        }
        guard let lastVisitDate = UserDefaults.standard.string(forKey: "lastVisitDate") else {
            return
        }
        if lastVisitDate != Date().toString(day: Date(), with: DateFormatter.yyyyMMdd) {
            UserDefaults.standard.setValue(Date().toString(day: Date(), with: DateFormatter.yyyyMMdd), forKey: "lastVisitDate")
            UserDefaults.standard.set(0, forKey: "todayExperience")
            try await repository.updateDailyQuest()
        }
    }
    
    func resetDailyQuests() -> Single<Void> {
        return Single.create { [weak self] observer  in
            do {
                if UserDefaults.standard.string(forKey: "lastVisitDate") == nil {
                    UserDefaults.standard.setValue(Date().yesterdayString(with: DateFormatter.yyyyMMdd), forKey: "lastVisitDate")
                }
                guard let lastVisitDate = UserDefaults.standard.string(forKey: "lastVisitDate") else {
                    throw UserDefaultsError.notFound
                }
                if lastVisitDate != Date().toString(day: Date(), with: DateFormatter.yyyyMMdd) {
                    UserDefaults.standard.setValue(Date().toString(day: Date(), with: DateFormatter.yyyyMMdd), forKey: "lastVisitDate")
                    UserDefaults.standard.set(0, forKey: "todayExperience")
                    self?.repository.resetDailyQuests()
                        .subscribe(onError: { error in
                            observer(.failure(error))
                        })
                        .disposed(by: DisposeBag())
                    return Disposables.create()
                }
                observer(.success(()))
            } catch {
                observer(.failure(error))
            }
            return Disposables.create()
        }
    }
    
    func isTodayExperienceAcquisitionMax() -> Bool{
        let todayExperience = UserDefaults.standard.integer(forKey: "todayExperience")
        if todayExperience == 5 {
            return true
        }
        UserDefaults.standard.set(todayExperience + 1, forKey: "todayExperience")
        return false
    }
    
    func isTodayExperienceAcquisitionMax() -> Single<Void> {
        return Single.create { observer in
            let todayExperience = UserDefaults.standard.integer(forKey: "todayExperience")
            if todayExperience == 5 {
                observer(.failure(UserDefaultsError.todayExperienceExceed))
            } else {
                UserDefaults.standard.set(todayExperience + 1, forKey: "todayExperience")
                observer(.success(()))
            }
            return Disposables.create()
        }
    }
}
