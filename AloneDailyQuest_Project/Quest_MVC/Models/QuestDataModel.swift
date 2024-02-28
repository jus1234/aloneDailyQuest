//
//  QuestData.swift
//  AloneDailyQuest_Project
//
//  Created by Matthew on 2/28/24.
//

import Foundation

struct QuestDataModel {
    let id: UUID
    var quest: String
    var date: Date
    var selectedDate: [Bool]
    var repeatDay: String
    
    init(id: UUID,quest: String, selectedDate: [Bool], repeatDay: String) {
        self.id = id
        self.quest = quest
        self.date = Date()
        self.selectedDate = selectedDate
        self.repeatDay = repeatDay
    }
}
