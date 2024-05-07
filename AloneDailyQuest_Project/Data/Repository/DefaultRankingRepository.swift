//
//  AccountRepository.swift
//  AloneDailyQuest_Project
//
//  Created by Wooseok on 5/7/24.
//

import Foundation

final class DefaultRankingRepository: RankingRepository {
    private let networkService: NetworkService
    private let decorder: JSONDecoder = JSONDecoder()
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func fetchRanking() async throws -> [UserInfo] {
        let data = try await networkService.request(.ranking)
        return try decorder.decode([UserInfoDTO].self, from: data).map { $0.toEntity() }
    }
    
    func fetchMyRanking(userId: String) async throws -> Int {
        let data = try await networkService.request(.myRanking(userId: UserIdRequestDTO(userId: userId)))
        return try decorder.decode(MyRankingResponseDTO.self, from: data).ranking
    }
}
