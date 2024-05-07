//
//  MyRankingResponseDTO.swift
//  AloneDailyQuest_Project
//
//  Created by Wooseok on 5/7/24.
//

import Foundation

struct MyRankingResponseDTO: Decodable {
    let userId: String
    let ranking: Int
    let experience: Int
    
    enum CodingKeys: String, CodingKey {
        case userId, ranking, experience
    }
}
