//
//  LoginErrorResponseDTO.swift
//  AloneDailyQuest_Project
//
//  Created by Wooseok on 5/7/24.
//

import Foundation

struct ErrorResponseDTO: Decodable {
    let error: String
    
    enum CodingKeys: String, CodingKey {
        case error
    }
}
