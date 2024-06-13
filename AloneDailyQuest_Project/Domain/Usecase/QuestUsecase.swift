//
//  QuestUsecase.swift
//  AloneDailyQuest_Project
//
//  Created by Matthew on 5/8/24.
//

import Foundation
import RxSwift

protocol QuestUsecase {
    func create(quest: QuestInfo) -> Single<Bool>
    func fetchQuests() -> Single<[QuestInfo]>
    func complete(quest: QuestInfo) -> Single<Bool>
    func save(quest: QuestInfo) -> Single<Bool>
    func delete(quest: QuestInfo) -> Single<Bool>
    func resetDailyQuests() -> Single<Void>
}

final class DefaultQuestUsecase: QuestUsecase {
    private let repository: QuestRepository
    
    init(repository: QuestRepository) {
        self.repository = repository
    }
    
    func create(quest: QuestInfo) -> Single<Bool> {
        return repository.create(quest: quest)
    }
    
    func fetchQuests() -> Single<[QuestInfo]> {
        return repository.fetchQuests()
    }
    
    func complete(quest: QuestInfo) -> Single<Bool> {
        return isTodayExperienceAcquisitionMax()
            .flatMap { [weak self] isMax -> Single<Bool> in
                if isMax {
                    return .just(false)
                }
                guard let updateResult = self?.repository.update(quest: quest) else {
                    return .error(NSError())
                }
                return updateResult
            }
            .flatMap { [weak self] result -> Single<Int> in
                switch result {
                case true:
                    let experience = UserDefaults.standard.integer(forKey: "experience")
                    guard
                        let nickName = UserDefaults.standard.string(forKey: "nickName"),
                        let addExperience = self?.repository.addExperience(userId: nickName, experience: experience + 1)
                    else {
                        return .error(NSError())
                    }
                    UserDefaults.standard.set(experience + 1, forKey: "experience")
                    return addExperience
                case false:
                    return .just(0)
                }
            }
            .map { $0 > 0 ? true : false }
    }
    
    func save(quest: QuestInfo) -> Single<Bool> {
        return repository.isExisting(quest: quest)
            .flatMap { [weak self] isExisting in
                switch isExisting {
                case true:
                    guard let update = self?.repository.update(quest: quest) else {
                        return .error(NSError())
                    }
                    return update
                case false:
                    guard let create = self?.repository.create(quest: quest) else {
                        return .error(NSError())
                    }
                    return create
                }
            }
    }
    
    func delete(quest: QuestInfo) -> Single<Bool> {
        return repository.delete(quest: quest)
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
    
    private func isTodayExperienceAcquisitionMax() -> Single<Bool> {
        return Single.create { observer in
            let todayExperience = UserDefaults.standard.integer(forKey: "todayExperience")
            if todayExperience == 5 {
                observer(.success(true))
            } else {
                UserDefaults.standard.set(todayExperience + 1, forKey: "todayExperience")
                observer(.success(false))
            }
            return Disposables.create()
        }
    }
}
