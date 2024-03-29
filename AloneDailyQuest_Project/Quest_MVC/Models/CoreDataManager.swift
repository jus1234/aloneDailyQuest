//
//  CoreDataManager.swift
//  AloneDailyQuest_Project
//
//  Created by 오정석 on 8/1/2024.
//

import UIKit
import CoreData

// MARK: - To Do 관리하는 매니저 (코어데이터 관리)

final class CoreDataManager {
    
    // 싱글톤으로 만들기
    static let shared = CoreDataManager()
    private init() {}
    
    // 앱 델리게이트
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    // 임시저장소
    lazy var context = appDelegate?.persistentContainer.viewContext
    
    // 엔티티 이름 (코어데이터에 저장된 객체)
    let modelName: String = "QuestData"
    
    // MARK: - [DELETE] 매일 자정 퀘스트데이터 삭제
    func deleteNonRepeatingQuestsForNewDay(completion: @escaping () -> Void) {
        // 임시저장소가 있는지 확인
        if let context = context {
            // 요청서
            let request = NSFetchRequest<NSManagedObject>(entityName: self.modelName)
            request.predicate = NSPredicate(format: "isMonday == false && isTuesday == false && isWednesday == false && isThursday == false && isFriday == false && isSaturday == false && isSunday == false")
            do {
                // 요청서를 통해서 데이터 가져오기 (조건에 일치하는 데이터 찾기) (fetch메서드)
                if let fetchedQuestList = try context.fetch(request) as? [QuestData] {
                    
                    print(fetchedQuestList)
                    // 임시저장소에서 (요청서를 통해서) 데이터 삭제하기 (delete메서드)
                    if let targetQuest = fetchedQuestList.first {
                        print(targetQuest)
                        context.delete(targetQuest)
                        
                        if context.hasChanges {
                            do {
                                try context.save()
                            } catch {
                                print(error)
                            }
                        }
                    }
                }
                completion()
            } catch {
                print("지우는 것 실패")
                completion()
            }
        }
    }
    
    // MARK: - [READ] 코어데이터에 저장된 데이터 모두 읽어오기
    func getQuestListFromCoreData() -> [QuestDataModel] {
        var questList: [QuestDataModel] = []
        // 임시 저장소 있는지 확인
        if let context = context {
            // 요청서
            let request = NSFetchRequest<NSManagedObject>(entityName: self.modelName)
            
            do {
                // 임시저장소에서 (요청서를 통해서) 데이터를 가져오기 (fetch메서드)
                if let fetchedQuestList = try context.fetch(request) as? [QuestData] {
                   questList = fetchedQuestList.map { data in
                       return QuestDataModel(id: data.id ,quest: data.quest ?? "", date: data.date ?? Date(), selectedDate: [data.isMonday, data.isTuesday, data.isWednesday, data.isThursday, data.isFriday, data.isSaturday, data.isSunday], repeatDay: data.repeatDay ?? "", completed: data.completed)
                   }
                }
            } catch {
                print("가져오는 것 실패")
            }
        }
        
        return questList
    }
    
    // MARK: - [CREATE] 코어데이터에 데이터 생성하기
    func saveQuestData(data: QuestDataModel, completion: @escaping () -> Void) {
        // 임시저장소에 있는지 확인
        if let context = context {
            // 임시 저장소에 있는 데이터를 그려줄 형태 파악하기
            if let entity = NSEntityDescription.entity(forEntityName: self.modelName, in: context) {
                
                // 임시 저장소에 올라가게 할 객체 만들기 (NSManagedObject ===> QuestData)
                if let questData = NSManagedObject(entity: entity, insertInto: context) as? QuestData {
                    // MARK: - QuestData에 실제 데이터 할당 ⭐️
                    questData.id = UUID()
                    questData.quest = data.quest
                    questData.date = Date() // 날짜는 저장하는 순간의 날짜로 생성
                    questData.isMonday = data.selectedDate[0]
                    questData.isTuesday = data.selectedDate[1]
                    questData.isWednesday = data.selectedDate[2]
                    questData.isThursday = data.selectedDate[3]
                    questData.isFriday = data.selectedDate[4]
                    questData.isSaturday = data.selectedDate[5]
                    questData.isSunday = data.selectedDate[6]
                    questData.repeatDay = data.repeatDay
                    questData.completed = data.completed
                    
                    if context.hasChanges {
                        do {
                            try context.save()
                            completion()
                        } catch {
                            print(error)
                            completion()
                        }
                    }
                }
            }
        }
    }

    // MARK: - [DELETE] 코어데이터에서 데이터 삭제하기 (일차하는 데이터 찾아서 ===> 삭제)
    
    func deletQuest(data: QuestDataModel, completion: @escaping () -> Void) {
        // 임시저장소가 있는지 확인
        if let context = context {
            // 요청서
            let request = NSFetchRequest<NSManagedObject>(entityName: self.modelName)
            request.predicate = NSPredicate(format: "id = %@", data.id as CVarArg)
            do {
                // 요청서를 통해서 데이터 가져오기 (조건에 일치하는 데이터 찾기) (fetch메서드)
                if let fetchedQuestList = try context.fetch(request) as? [QuestData] {
                    
                    print(fetchedQuestList)
                    // 임시저장소에서 (요청서를 통해서) 데이터 삭제하기 (delete메서드)
                    if let targetQuest = fetchedQuestList.first {
                        print(targetQuest)
                        context.delete(targetQuest)
                        
                        if context.hasChanges {
                            do {
                                try context.save()
                                completion()
                            } catch {
                                print(error)
                                completion()
                            }
                        }
                    }
                }
                completion()
            } catch {
                print("지우는 것 실패")
                completion()
            }
        }
    }

    // MARK: - [UPDATE] 코어데이터에서 데이터 수정하기 (일치하는 데이터 찾아서 ===> 수정)
    func updateQuest(newQuestData: QuestDataModel, completion: @escaping () -> Void) {
        // 날짜 옵셔널 바인딩
        let id = newQuestData.id
        
        // 임시저장소 있는지 확인
        if let context = context {
            // 요청서
            let request = NSFetchRequest<NSManagedObject>(entityName: self.modelName)
            // 단서 / 찾기 위한 조건 설정
            request.predicate = NSPredicate(format: "id = %@", id as CVarArg)
            
            do {
                // 요청서를 통해서 데이터 가져오기
                if let fetchedQuestList = try context.fetch(request) as? [QuestData] {
                    // 배열의 첫번째
                    if let targetQuest = fetchedQuestList.first {
                        // MARK: - QuestData에 실제 데이터 재할당(바꾸기) ⭐️
                        targetQuest.quest = newQuestData.quest
                        targetQuest.isMonday = newQuestData.selectedDate[0]
                        targetQuest.isTuesday = newQuestData.selectedDate[1]
                        targetQuest.isWednesday = newQuestData.selectedDate[2]
                        targetQuest.isThursday = newQuestData.selectedDate[3]
                        targetQuest.isFriday = newQuestData.selectedDate[4]
                        targetQuest.isSaturday = newQuestData.selectedDate[5]
                        targetQuest.isSunday = newQuestData.selectedDate[6]
                        targetQuest.repeatDay = newQuestData.repeatDay
                        targetQuest.completed = newQuestData.completed
                        
                        //appDelegate?.saveContext() // 앱델리게이트의 메서드로 해도됨
                        if context.hasChanges {
                            do {
                                try context.save()
                                completion()
                            } catch {
                                print(error)
                                completion()
                            }
                        }
                    }
                }
                completion()
            } catch {
                print("지우는 것 실패")
                completion()
            }
        }
    }

}

