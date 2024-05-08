//
//  RankingRepository.swift
//  AloneDailyQuest_Project
//
//  Created by Wooseok on 5/7/24.
//

import Foundation

protocol RankingRepository {
    func fetchRanking() async throws -> [UserInfo]
    func fetchUserRanking(nickName: String) async throws -> Int
}
