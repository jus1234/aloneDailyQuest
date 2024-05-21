//
//  DefaultQuestRepository.swift
//  AloneDailyQuest_Project
//
//  Created by Matthew on 5/8/24.
//

import CoreData

final class DefaultQuestRepository: QuestRepository {
    private let networkService: NetworkService
    private let decorder: JSONDecoder = JSONDecoder()
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "AloneDailyQuest_Project")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                assertionFailure("CoreDataStorage Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    private lazy var context: NSManagedObjectContext = {
        return persistentContainer.viewContext
    }()
    private let modelName: String = "QuestData"
}

// MARK: - Public Method
extension DefaultQuestRepository {
    func createQuest(questInfo: QuestInfo) async throws {
        guard let entity = NSEntityDescription.entity(forEntityName: self.modelName, in: context) else {
            throw NSError(domain: "Error : Coredata not found entity quest error", code: 0)
        }
        
        guard let questData = NSManagedObject(entity: entity, insertInto: context) as? QuestData else {
            throw NSError(domain: "Error : Coredata not found quest error ", code: 0)
        }

        questData.id = UUID()
        questData.quest = questInfo.quest
        questData.date = Date()
        questData.isMonday = questInfo.selectedDate[0]
        questData.isTuesday = questInfo.selectedDate[1]
        questData.isWednesday = questInfo.selectedDate[2]
        questData.isThursday = questInfo.selectedDate[3]
        questData.isFriday = questInfo.selectedDate[4]
        questData.isSaturday = questInfo.selectedDate[5]
        questData.isSunday = questInfo.selectedDate[6]
        questData.repeatDay = questInfo.repeatDay
        questData.completed = questInfo.completed
        
        if context.hasChanges {
            try context.save()
        }
    }
    
    func readQuest() async throws -> [QuestInfo] {
        var questList: [QuestInfo] = []
        
        let request = NSFetchRequest<NSManagedObject>(entityName: self.modelName)
        
        guard let fetchedQuestList = try context.fetch(request) as? [QuestData] else {
            throw NSError(domain: "Error : Coredata fetch failed error", code: 0)
        }
        
        questList = fetchedQuestList.map { data in
           return QuestInfo(id: data.id,
                            quest: data.quest ?? "",
                            date: data.date ?? Date(),
                            selectedDate: [data.isMonday,
                                           data.isTuesday,
                                           data.isWednesday,
                                           data.isThursday,
                                           data.isFriday,
                                           data.isSaturday,
                                           data.isSunday],
                            repeatDay: data.repeatDay ?? "",
                            completed: data.completed)
        }
        return questList
    }
    
    func updateQuest(newQuestInfo: QuestInfo) async throws {
        let request = NSFetchRequest<NSManagedObject>(entityName: self.modelName)
        request.predicate = NSPredicate(format: "id = %@", newQuestInfo.id as CVarArg)
        
        guard let fetchedQuestList = try context.fetch(request) as? [QuestData] else {
            throw NSError(domain: "Error : Coredata fetch failed error", code: 0)
        }

        guard let targetQuest = fetchedQuestList.first else {
            throw NSError(domain: "Error : Coredata not found first fetch data error", code: 0)
        }
        
        targetQuest.quest = newQuestInfo.quest
        targetQuest.isMonday = newQuestInfo.selectedDate[0]
        targetQuest.isTuesday = newQuestInfo.selectedDate[1]
        targetQuest.isWednesday = newQuestInfo.selectedDate[2]
        targetQuest.isThursday = newQuestInfo.selectedDate[3]
        targetQuest.isFriday = newQuestInfo.selectedDate[4]
        targetQuest.isSaturday = newQuestInfo.selectedDate[5]
        targetQuest.isSunday = newQuestInfo.selectedDate[6]
        targetQuest.repeatDay = newQuestInfo.repeatDay
        targetQuest.completed = newQuestInfo.completed
        
        if context.hasChanges {
            try context.save()
        }
    }
    
    func deleteQuest(questInfo: QuestInfo) async throws {
        let request = NSFetchRequest<NSManagedObject>(entityName: self.modelName)
        request.predicate = NSPredicate(format: "id = %@", questInfo.id as CVarArg)
        
        guard let fetchedQuestList = try context.fetch(request) as? [QuestData] else {
            throw NSError(domain: "Error : Coredata fetch failed error", code: 0)
        }

        guard let targetQuest = fetchedQuestList.first else {
            throw NSError(domain: "Error : Coredata not found first fetch data error", code: 0)
        }
            
        context.delete(targetQuest)
        if context.hasChanges {
            try context.save()
        }
    }
    
    func repeatingQuestNewDay() async throws {
        let request = NSFetchRequest<NSManagedObject>(entityName: self.modelName)
        request.predicate = NSPredicate(format: "isMonday == false && isTuesday == false && isWednesday == false && isThursday == false && isFriday == false && isSaturday == false && isSunday == false")
        
        guard let fetchedQuestList = try context.fetch(request) as? [QuestData] else {
            throw NSError(domain: "Error : Coredata fetch failed error", code: 0)
        }
        
        guard let targetQuest = fetchedQuestList.first else {
            throw NSError(domain: "Error : Coredata not found first fetch data error", code: 0)
        }
        
        context.delete(targetQuest)
        if context.hasChanges {
            try context.save()
        }
    }
    
    func fetchUserInfo(userId: String) async throws -> UserInfo {
        let data = try await networkService.request(.member(userId: UserIdRequestDTO(userId: userId)))
        return try decorder.decode(UserInfoDTO.self, from: data).toEntity()
    }
    
    func fetchExperience(userId: String) async throws -> Int {
        let data = try await networkService.request(.experience(userId: UserIdRequestDTO(userId: userId)))
        return try decorder.decode(ExperienceResponseDTO.self, from: data).experience
    }
    
    func addExperience(userId: String, experience: Int) async throws -> Int {
        let data = try await networkService.request(.addExperience(user: UserInfoDTO(userId: userId,
                                                                                     experience: experience)))
        return try decorder.decode(ExperienceResponseDTO.self, from: data).experience
    }
}
