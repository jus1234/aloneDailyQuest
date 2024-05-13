//
//  DefaultProfileRepository.swift
//  AloneDailyQuest_Project
//
//  Created by Matthew on 5/12/24.
//

import Foundation

final class DefaultProfileRepository: ProfileRepository {
    private let networkService: NetworkService
    private let decorder: JSONDecoder = JSONDecoder()
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func fetchUserInfo(userId: String) async throws -> UserInfo {
        let data = try await networkService.request(.member(userId: UserIdRequestDTO(userId: userId)))
        return try decorder.decode(UserInfoDTO.self, from: data).toEntity()
    }
    
    func fetchExperience(userId: String) async throws -> Int {
        let data = try await networkService.request(.experience(userId: UserIdRequestDTO(userId: userId)))
        return try decorder.decode(ExperienceResponseDTO.self, from: data).experience
    }
}
