//
//  QuestUsecase.swift
//  AloneDailyQuest_Project
//
//  Created by Matthew on 5/8/24.
//

import Foundation
import RxSwift

protocol QuestUsecase {
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
    
    func create(quest: QuestInfo) -> Completable {
        return repository.create(quest: quest)
    }
    
    func fetchQuests() -> Single<[QuestInfo]> {
        return repository.fetchQuests()
    }
    
    func update(quest: QuestInfo) -> Completable {
        return repository.update(quest: quest)
    }
    
    func delete(quest: QuestInfo) -> Completable {
        return repository.delete(quest: quest)
    }
    
    func fetchUserInfo(userId: String) -> Single<UserInfo> {
        return repository.fetchUserInfo(userId: userId)
    }
    
    func fetchExperience(userId: String) -> Single<Int> {
        return repository.fetchExperience(userId: userId)
    }
    
    func addExperience(userId: String, experience: Int) -> Single<Int> {
        return repository.addExperience(userId: userId, experience: experience)
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
