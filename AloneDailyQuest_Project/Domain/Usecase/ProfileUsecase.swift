//
//  ProfileUsecase.swift
//  AloneDailyQuest_Project
//
//  Created by Matthew on 5/12/24.
//

import Foundation
import RxSwift

protocol ProfileUsecase {
    func fetchUserInfo(userId: String) async throws -> UserInfo
    func fetchExperience(userId: String) async throws -> Int
    func dropMembership() -> Single<Void>
}

final class DefaultProfileUsecase: ProfileUsecase {
    private let repository: ProfileRepository
    private let questRepository: QuestRepository
    
    init(repository: ProfileRepository, questRepository: QuestRepository) {
        self.repository = repository
        self.questRepository = questRepository
    }
    
    func fetchUserInfo(userId: String) async throws -> UserInfo {
        return try await repository.fetchUserInfo(userId: userId)
    }
    
    func fetchExperience(userId: String) async throws -> Int {
        return try await repository.fetchExperience(userId: userId)
    }
    
    func dropMembership() -> Single<Void> {
        return questRepository.deleteQuests()
            .do(onSuccess: {
                UserDefaults.standard.removeObject(forKey: "nickName")
                UserDefaults.standard.removeObject(forKey: "experience")
                UserDefaults.standard.removeObject(forKey: "todayExperience")
            })
    }
}
