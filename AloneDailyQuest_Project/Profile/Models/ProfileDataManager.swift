//
//  ProfileDataManager.swift
//  AloneDailyQuest_Project
//
//  Created by Joy Kim on 2023/12/16.
//

import UIKit


class DataManager {
    private var profileMenuArray: [Profile] = []
    
    func makeProfileData() {
        profileMenuArray = [
            Profile(profileIcon: UIImage(named: "bulb"), profileMenu: "문의하기"),
            Profile(profileIcon: UIImage(named: "time"), profileMenu: "초대하기")
        ]
    }
    
    func getProfileData() -> [Profile] {
        return profileMenuArray
    }
}
