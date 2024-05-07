//
//  DefaultAccountRepository.swift
//  AloneDailyQuest_Project
//
//  Created by Wooseok on 5/7/24.
//

import Foundation

final class DefaultAccountRepository: AccountRepository {
    private let networkService: NetworkService
    private let decorder: JSONDecoder = JSONDecoder()
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func signup(userId: String) async throws {
        let data = try await networkService.request(.login(userId: UserIdRequestDTO(userId: userId)))
        do {
            _ = try decorder.decode(LoginResponseDTO.self, from: data)
        } catch {
            do {
                let errorMessage = try decorder.decode(ErrorResponseDTO.self, from: data)
                throw SignupError(errorMessage: errorMessage.error)
            } catch {
                throw error
            }
        }
    }
    
    func checkId(userId: String) async throws -> Bool {
        let data = try await networkService.request(.checkId(userId: UserIdRequestDTO(userId: userId)))
        return try decorder.decode(CheckIdResponseDTO.self, from: data).exists
    }
    
    func login(userId: String) async throws -> Bool {
        let data = try await networkService.request(.login(userId: UserIdRequestDTO(userId: userId)))
        do {
            _ = try decorder.decode(LoginResponseDTO.self, from: data)
            return true
        } catch {
            do {
                _ = try decorder.decode(ErrorResponseDTO.self, from: data)
                throw LoginError.invalidCredentials
            } catch {
                throw error
            }
        }
    }
    
    func fetchUserInfo(userId: String) async throws -> UserInfo {
        let data = try await networkService.request(.member(userId: UserIdRequestDTO(userId: userId)))
        return try decorder.decode(UserInfoDTO.self, from: data).toEntity()
    }
    
    func fetchExperience(userId: String) async throws -> Int {
        let data = try await networkService.request(.experience(userId: UserIdRequestDTO(userId: userId)))
        return try decorder.decode(ExperienceResponseDTO.self, from: data).experience
    }
    
    func addExperience(user: UserInfo) async throws -> Int {
        let data = try await networkService.request(.addExperience(user: UserInfoDTO(userId: user.fetchNickName(), 
                                                                                     experience: user.fetchExperience())))
        return try decorder.decode(ExperienceResponseDTO.self, from: data).experience
    }
    
    
}

