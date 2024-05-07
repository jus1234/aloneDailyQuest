//
//  CheckIdResponseDTO.swift
//  AloneDailyQuest_Project
//
//  Created by Wooseok on 5/7/24.
//

import Foundation

struct CheckIdResponseDTO: Decodable {
    let exists: Bool
    
    enum CodingKeys: String, CodingKey {
        case exists
    }
}
