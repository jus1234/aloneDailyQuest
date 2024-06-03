//
//  DefaultQuestRepository.swift
//  AloneDailyQuest_Project
//
//  Created by Matthew on 5/8/24.
//

import CoreData
import RxSwift

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

        questData.make(from: questInfo)
        
        if context.hasChanges {
            try context.save()
        }
    }
    
    func create(quest: QuestInfo) -> Completable {
        return Completable.create { [weak self] observer in
            do {
                guard 
                    let self,
                    let entity = NSEntityDescription.entity(forEntityName: modelName, in: context),
                    let questData = NSManagedObject(entity: entity, insertInto: context) as? QuestData
                else {
                    throw CoreDataError.create
                }
                questData.make(from: quest)
                if context.hasChanges {
                    try context.save()
                }
                observer(.completed)
            } catch {
                observer(.error(error))
            }
            return Disposables.create()
        }
    }
    
    func readQuest() async throws -> [QuestInfo] {
        let request = NSFetchRequest<NSManagedObject>(entityName: self.modelName)
        
        guard let fetchedQuestList = try context.fetch(request) as? [QuestData] else {
            throw NSError(domain: "Error : Coredata fetch failed error", code: 0)
        }
        
        return fetchedQuestList.map { $0.toDomain() }
    }
    
    func fetchQuests() -> Single<[QuestInfo]> {
        return Single.create { [weak self] observer in
            do {
                guard
                    let modelName = self?.modelName,
                    let quests = try self?.context.fetch(NSFetchRequest<NSManagedObject>(entityName: modelName)) as? [QuestData]
                else {
                    throw CoreDataError.fetch
                }
                observer(.success(quests.map { $0.toDomain() }))
            } catch {
                observer(.failure(error))
            }
            return Disposables.create()
        }
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
        
        targetQuest.update(from: newQuestInfo)
        
        if context.hasChanges {
            try context.save()
        }
    }
    
    func update(quest: QuestInfo) -> Completable {
        return Completable.create { [weak self] observer in
            do {
                guard let self else { throw CoreDataError.general }
                
                let request = NSFetchRequest<NSManagedObject>(entityName: modelName)
                request.predicate = NSPredicate(format: "id = %@", quest.id as CVarArg)
                
                guard
                    let fetchedQuestList = try context.fetch(request) as? [QuestData],
                    let targetQuest = fetchedQuestList.first
                else {
                    throw CoreDataError.update
                }
                
                targetQuest.update(from: quest)
                
                if context.hasChanges {
                    try context.save()
                }
                
                observer(.completed)
            } catch {
                observer(.error(CoreDataError.update))
            }
            return Disposables.create()
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
    
    func delete(quest: QuestInfo) -> Completable {
        return Completable.create { [weak self] observer in
            do {
                guard let self else { throw CoreDataError.general }
                
                let request = NSFetchRequest<NSManagedObject>(entityName: modelName)
                request.predicate = NSPredicate(format: "id = %@", quest.id as CVarArg)
                
                guard
                    let fetchedQuestList = try context.fetch(request) as? [QuestData],
                    let targetQuest = fetchedQuestList.first
                else {
                    throw CoreDataError.update
                }
                
                context.delete(targetQuest)
                
                if context.hasChanges {
                    try context.save()
                }
                
                observer(.completed)
            } catch {
                observer(.error(CoreDataError.update))
            }
            return Disposables.create()
        }
    }
    
    func deleteQuests() async throws {
        let request = NSFetchRequest<NSManagedObject>(entityName: self.modelName)
        
        let fetchedQuestList = try context.fetch(request)
        
        for quest in fetchedQuestList {
            context.delete(quest)
        }
        
        if context.hasChanges {
            try context.save()
        }
    }
    
    func deleteQuests() -> Completable {
        return Completable.create { [weak self] observer in
            do {
                guard let self else { throw CoreDataError.general }
                let request = NSFetchRequest<NSManagedObject>(entityName: modelName)
                
                let quests = try context.fetch(request)
                quests.forEach { quest in
                    self.context.delete(quest)
                }
                
                if context.hasChanges {
                    try context.save()
                }
                observer(.completed)
            } catch {
                observer(.error(error))
            }
            return Disposables.create()
        }
    }
    
    func fetchUserInfo(userId: String) async throws -> UserInfo {
        let data = try await networkService.request(.member(userId: UserIdRequestDTO(userId: userId)))
        return try decorder.decode(UserInfoDTO.self, from: data).toEntity()
    }
    
    func fetchUserInfo(userId: String) -> Single<UserInfo> {
        return networkService
            .request(.member(userId: UserIdRequestDTO(userId: userId)))
            .flatMap { [weak self] data in
                do {
                    guard 
                        let userInfo = try self?.decorder.decode(UserInfoDTO.self, from: data).toEntity()
                    else {
                        throw NetworkError.dataError
                    }
                    return Single.just(userInfo)
                } catch {
                    return Single.error(NetworkError.dataError)
                }
            }
    }
    
    func fetchExperience(userId: String) async throws -> Int {
        let data = try await networkService.request(.experience(userId: UserIdRequestDTO(userId: userId)))
        return try decorder.decode(ExperienceResponseDTO.self, from: data).experience
    }
    
    func fetchExperience(userId: String) -> Single<Int> {
        return networkService
            .request(.experience(userId: UserIdRequestDTO(userId: userId)))
            .flatMap { [weak self] data in
                do {
                    guard 
                        let experience = try self?.decorder.decode(ExperienceResponseDTO.self, from: data).experience
                    else {
                        throw NetworkError.dataError
                    }
                    return Single.just(experience)
                } catch {
                    return Single.error(error)
                }
            }
    }
    
    func addExperience(userId: String, experience: Int) async throws -> Int {
        let data = try await networkService.request(.addExperience(user: UserInfoDTO(userId: userId,
                                                                                     experience: experience)))
        return try decorder.decode(ExperienceResponseDTO.self, from: data).experience
    }
    
    func addExperience(userId: String, experience: Int) -> Single<Int> {
        return networkService
            .request(.addExperience(user: UserInfoDTO(userId: userId,experience: experience)))
            .flatMap { [weak self] data in
                do {
                    guard
                        let addedExperience = try self?.decorder.decode(ExperienceResponseDTO.self, from: data).experience
                    else {
                        throw NetworkError.dataError
                    }
                    return Single.just(addedExperience)
                } catch {
                    return Single.error(error)
                }
            }
    }
    
    func updateDailyQuest() async throws {
        let request = NSFetchRequest<NSManagedObject>(entityName: self.modelName)
        
        guard let fetchedQuestList = try context.fetch(request) as? [QuestData] else {
            throw NSError(domain: "Error : Coredata fetch failed error", code: 0)
        }
        
        fetchedQuestList.forEach { quest in
            quest.completed = false
        }
        
        if context.hasChanges {
            try context.save()
        }
    }
    
    func resetDailyQuests() -> Completable {
        return Completable.create { [weak self] observer in
            do {
                guard
                    let self,
                    let quests = try context.fetch(NSFetchRequest<NSManagedObject>(entityName: modelName)) as? [QuestData]
                else {
                    throw CoreDataError.fetch
                }
                
                quests.forEach { quest in
                    quest.completed = false
                }
                
                if context.hasChanges {
                    try context.save()
                }
                observer(.completed)
            } catch {
                observer(.error(error))
            }
            return Disposables.create()
        }
    }
}
