//
//  RankingUsecase.swift
//  AloneDailyQuest_Project
//
//  Created by Wooseok on 5/8/24.
//

import Foundation

protocol RankingUsecase {
    func fetch() async throws -> [UserInfo]
    func fetchUserRanking(userId: String) async throws -> Int
}

final class DefaultRankingUsecase: RankingUsecase {
    private let repository: RankingRepository
    
    init(repository: RankingRepository) {
        self.repository = repository
    }
    
    func fetch() async throws -> [UserInfo] {
        return try await repository.fetchRanking()
    }
    
    func fetchUserRanking(userId: String) async throws -> Int {
        return try await repository.fetchUserRanking(userId: userId)
    }
    
    
}
