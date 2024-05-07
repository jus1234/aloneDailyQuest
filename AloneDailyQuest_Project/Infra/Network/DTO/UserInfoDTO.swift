//
//  UserInfoDTO.swift
//  AloneDailyQuest_Project
//
//  Created by Wooseok on 5/7/24.
//

import Foundation

struct UserInfoDTO: Codable {
    let userId: String
    let experience: Int
}

extension UserInfoDTO {
    func toEntity() -> UserInfo {
       return .init(nickName: userId, 
                    experience: experience)
    }
}
