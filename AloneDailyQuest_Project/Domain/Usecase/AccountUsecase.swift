//
//  AccountUsecase.swift
//  AloneDailyQuest_Project
//
//  Created by Wooseok on 5/8/24.
//

import Foundation

protocol AccountUsecase {
    func signup(userId: String) async throws
    func checkId(userId: String) async throws -> Bool
    func fetchUserInfo(userId: String) async throws -> UserInfo
    func fetchExperience(userId: String) async throws -> Int
}

final class DefaultAccountUsecase: AccountUsecase {
    private let repository: AccountRepository
    
    init(repository: AccountRepository) {
        self.repository = repository
    }
    
    func signup(userId: String) async throws {
        try await repository.signup(userId: userId)
    }
    
    func checkId(userId: String) async throws -> Bool {
        return try await repository.checkId(userId: userId)
    }
    
    func fetchUserInfo(userId: String) async throws -> UserInfo {
        return try await repository.fetchUserInfo(userId: userId)
    }
    
    func fetchExperience(userId: String) async throws -> Int {
        return try await repository.fetchExperience(userId: userId)
    }
}
