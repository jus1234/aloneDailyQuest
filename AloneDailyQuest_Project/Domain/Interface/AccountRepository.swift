//
//  AccountRepository.swift
//  AloneDailyQuest_Project
//
//  Created by Wooseok on 5/7/24.
//

import Foundation

protocol AccountRepository {
    func signup(userId: String) async throws
    func checkId(userId: String) async throws -> Bool
    func fetchUserInfo(userId: String) async throws -> UserInfo
    func fetchExperience(userId: String) async throws -> Int
}
