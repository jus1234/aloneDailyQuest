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
    
}

extension QuestData : Identifiable {

}
