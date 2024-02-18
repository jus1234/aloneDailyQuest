//
//  UserInfoManager.swift
//  AloneDailyQuest_Project
//
//  Created by Matthew on 1/25/24.
//

import Foundation

class UserInfoManager {
    
    static let shared: UserInfoManager = UserInfoManager()
    var user: UserInfo? = UserInfo(nickName: "매튜", experience: 0)
    
    func createUserInfo(inputNickName: String) {
        self.user = UserInfo(nickName: inputNickName, experience: 0)
    }
    
    func readUserInfo() -> UserInfo? {
        return self.user
    }
    
    func updataUserInfo(inputNickName: String, updateExperience: Int) {
        if user?.fetchNickName() == inputNickName {
            self.user?.formExperience(input: updateExperience)
        }
    }
    
    func deleteUserInfo(inputNickName: String) {
        if user?.fetchNickName() == inputNickName {
            self.user = nil
        }
    }
}
