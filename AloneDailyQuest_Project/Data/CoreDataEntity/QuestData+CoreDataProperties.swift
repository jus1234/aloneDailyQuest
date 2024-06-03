//
//  QuestData+CoreDataProperties.swift
//  AloneDailyQuest_Project
//
//  Created by 오정석 on 8/1/2024.
//
//

import Foundation
import CoreData


extension QuestData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<QuestData> {
        return NSFetchRequest<QuestData>(entityName: "QuestData")
    }

    @NSManaged public var quest: String?
    @NSManaged public var date: Date?
    @NSManaged public var isMonday: Bool
    @NSManaged public var isTuesday: Bool
    @NSManaged public var isWednesday: Bool
    @NSManaged public var isThursday: Bool
    @NSManaged public var isFriday: Bool
    @NSManaged public var isSaturday: Bool
    @NSManaged public var isSunday: Bool
    @NSManaged public var repeatDay: String?
    @NSManaged public var id: UUID
    @NSManaged public var completed: Bool
}

extension QuestData : Identifiable {
    func toDomain() -> QuestInfo {
        return QuestInfo(id: self.id,
                         quest: self.quest ?? "",
                         date: self.date ?? Date(),
                         selectedDate: [self.isMonday,
                                        self.isTuesday,
                                        self.isWednesday,
                                        self.isThursday,
                                        self.isFriday,
                                        self.isSaturday,
                                        self.isSunday],
                         repeatDay: self.repeatDay ?? "",
                         completed: self.completed)
    }
    
    func make(from questInfo: QuestInfo) {
        self.id = UUID()
        self.quest = questInfo.quest
        self.date = Date()
        self.isMonday = questInfo.selectedDate[0]
        self.isTuesday = questInfo.selectedDate[1]
        self.isWednesday = questInfo.selectedDate[2]
        self.isThursday = questInfo.selectedDate[3]
        self.isFriday = questInfo.selectedDate[4]
        self.isSaturday = questInfo.selectedDate[5]
        self.isSunday = questInfo.selectedDate[6]
        self.repeatDay = questInfo.repeatDay
        self.completed = questInfo.completed
    }
    
    func update(from questInfo: QuestInfo) {
        self.quest = questInfo.quest
        self.isMonday = questInfo.selectedDate[0]
        self.isTuesday = questInfo.selectedDate[1]
        self.isWednesday = questInfo.selectedDate[2]
        self.isThursday = questInfo.selectedDate[3]
        self.isFriday = questInfo.selectedDate[4]
        self.isSaturday = questInfo.selectedDate[5]
        self.isSunday = questInfo.selectedDate[6]
        self.repeatDay = questInfo.repeatDay
        self.completed = questInfo.completed
    }
}
