//
//  ProfileRepository.swift
//  AloneDailyQuest_Project
//
//  Created by Matthew on 5/12/24.
//

import Foundation

protocol ProfileRepository {
    func fetchUserInfo(userId: String) async throws -> UserInfo
    func fetchExperience(userId: String) async throws -> Int
}
