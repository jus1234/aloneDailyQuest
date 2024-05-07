//
//  LoginResponseDTO.swift
//  AloneDailyQuest_Project
//
//  Created by Wooseok on 5/7/24.
//

import Foundation

struct LoginResponseDTO: Decodable {
    let message: String
    
    enum CodingKeys: String, CodingKey {
        case message
    }
}
