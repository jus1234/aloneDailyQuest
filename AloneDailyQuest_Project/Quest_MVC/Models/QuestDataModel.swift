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
    
    init(quest: String, selectedDate: [Bool]) {
        self.id = UUID()
        self.quest = quest
        self.date = Date()
        self.selectedDate = selectedDate
    }
}
