//
//  ExperienceResponseDTO.swift
//  AloneDailyQuest_Project
//
//  Created by Wooseok on 5/7/24.
//

import Foundation

struct ExperienceResponseDTO: Decodable {
    let experience: Int
    
    enum CodingKeys: String, CodingKey {
        case experience
    }
}
