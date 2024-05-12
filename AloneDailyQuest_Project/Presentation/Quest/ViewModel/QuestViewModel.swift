//
//  QuestViewModel.swift
//  AloneDailyQuest_Project
//
//  Created by Matthew on 5/10/24.
//

import Foundation

@MainActor
final class QuestViewModel: ViewModel {
    struct Input {
        var viewDidLoad: Observable<Void>
        var deleteTrigger: Observable<QuestInfo>
        var experienceTrigger: Observable<Int>
    }
    
    struct Output {
        var questList: Observable<[QuestInfo]>
        var errorMessage: Observable<String>
        var experience: Observable<Int>
    }
    
    private let usecase: QuestUsecase
    private let questList: Observable<[QuestInfo]> = Observable([])
    private let errorMessage: Observable<String> = Observable("")
    private let nickName: String = UserDefaults.standard.object(forKey: "nickName") as! String
    private var experience: Int = 0
    
    init(usecase: QuestUsecase) {
        self.usecase = usecase
    }
    
    private func viewDidLoad() {
        Task {
            await fetchQuest()
            checkUserDefaultsLastVisitDate()
            await checkUserDefaultsDeleteData()
            await fetchUserInfo()
        }
    }
    
    private func fetchQuest() async {
        Task {
            do {
                try await usecase.repeatingQuestNewDay()
                questList.value = try await usecase.readQuest()
            } catch {
                errorMessage.value = error.localizedDescription
            }
        }
    }
    
    private func checkUserDefaultsLastVisitDate() {
        if UserDefaults.standard.object(forKey: "lastVisitDate") == nil {
            UserDefaults.standard.set(Date(), forKey: "lastVisitDate")
        }
    }
    
    private func checkUserDefaultsDeleteData() async {
        let currentDate = Date()
        let calendar = Calendar.current
        let lastVisitDate = UserDefaults.standard.object(forKey: "lastVisitDate") as? Date ?? currentDate
        
        if calendar.isDate(lastVisitDate, inSameDayAs: currentDate) == false {
            do {
                try await usecase.repeatingQuestNewDay()
                UserDefaults.standard.set(currentDate, forKey: "lastVisitDate")
            } catch {
                errorMessage.value = error.localizedDescription
            }
        }
    }
    
    func fetchUserInfo() async {
        Task {
            do {
                self.experience =  try await usecase.fetchExperience(userId: UserDefaults.standard.object(forKey: "nickName") as! String)
            } catch {
                errorMessage.value = error.localizedDescription
            }
        }
    }
    
    func deleteQuest(quest: QuestInfo) {
        Task {
            do {
                try await usecase.deleteQuest(questInfo: quest)
            } catch {
                errorMessage.value = error.localizedDescription
            }
        }
    }
    
    func updateQuest(quest: QuestInfo) {
        Task {
            do {
                try await usecase.updateQuest(newQuestInfo: quest)
            } catch {
                errorMessage.value = error.localizedDescription
            }
        }
    }
    
    func updateExperience(experience: Int) {
        Task {
            do {
                self.experience = try await usecase.addExperience(user: UserInfo(nickName: nickName, experience: experience))
            } catch {
                errorMessage.value = error.localizedDescription
            }
        }
    }
    
    func transform(input: Input) -> Output {
        input.viewDidLoad.bind { _ in
            self.viewDidLoad()
        }
        
        input.deleteTrigger.bind { quest in
            self.deleteQuest(quest: quest)
            self.viewDidLoad()
        }
        
        input.experienceTrigger.bind { experience in
            self.updateExperience(experience: experience)
            self.viewDidLoad()
        }
        
        return .init(questList: self.questList,
                     errorMessage: self.errorMessage, 
                     experience: Observable(self.experience))
    }
}
