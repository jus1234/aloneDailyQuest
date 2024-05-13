//
//  ProfileUsecase.swift
//  AloneDailyQuest_Project
//
//  Created by Matthew on 5/12/24.
//

import Foundation

protocol ProfileUsecase {
    func fetchUserInfo(userId: String) async throws -> UserInfo
    func fetchExperience(userId: String) async throws -> Int
}

final class DefaultProfileUsecase: ProfileUsecase {
    private let repository: ProfileRepository
    
    init(repository: ProfileRepository) {
        self.repository = repository
    }
    
    func fetchUserInfo(userId: String) async throws -> UserInfo {
        return try await repository.fetchUserInfo(userId: userId)
    }
    
    func fetchExperience(userId: String) async throws -> Int {
        return try await repository.fetchExperience(userId: userId)
    }
}
