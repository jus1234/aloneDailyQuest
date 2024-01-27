//
//  UserInfo.swift
//  AloneDailyQuest_Project
//
//  Created by Matthew on 1/25/24.
//

import Foundation

struct UserInfo {
    private let nickName: String
    private var experience: Int
    
    init(nickName: String, experience: Int) {
        self.nickName = nickName
        self.experience = experience
    }
    
    func fetchLevel() -> Int {
        return (experience / 10) + 1
    }
    
    func fetchNickName() -> String {
        return self.nickName
    }
    
    func fetchExperience() -> Int {
        return self.experience
    }
    
    mutating func formExperience(input: Int) {
        self.experience = input
    }
}
