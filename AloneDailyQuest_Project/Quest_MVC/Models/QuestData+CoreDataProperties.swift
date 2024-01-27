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
    @NSManaged public var complete: Bool
    
    @NSManaged public var sunday: Bool
    @NSManaged public var monday: Bool
    @NSManaged public var tuesday: Bool
    @NSManaged public var wednesday: Bool
    @NSManaged public var thursday: Bool
    @NSManaged public var friday: Bool
    @NSManaged public var saturday: Bool
    
}

extension QuestData : Identifiable {

}
