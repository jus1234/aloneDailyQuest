//
//  Quest.swift
//  AloneDailyQuest_Project
//
//  Created by 오정석 on 12/12/2023.
//

import UIKit

struct Quest {
    
    static var questNumbers: Int = 0
    
    let questId: Int
    let questTitle: String?
    var questDetail: String?
    
    init(questTitle: String?, questDetail: String? = nil) {
        self.questId = Quest.questNumbers
        
        self.questTitle = questTitle
        self.questDetail = questDetail
        
        Quest.questNumbers += 1
    }
}
