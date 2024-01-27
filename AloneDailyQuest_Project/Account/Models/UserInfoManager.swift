//
//  UserInfoManager.swift
//  AloneDailyQuest_Project
//
//  Created by Matthew on 1/25/24.
//

import Foundation

class UserInfoManager {
    
    private var user: UserInfo?
    
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