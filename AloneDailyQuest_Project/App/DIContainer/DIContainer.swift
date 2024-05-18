//
//  DIContainer.swift
//  AloneDailyQuest_Project
//
//  Created by Wooseok on 5/17/24.
//

import Foundation

final class DIContainer {
    private let networkSevice: NetworkService = DefaultNetworkService()
    
    func makeAccountUsecase() -> AccountUsecase {
        return DefaultAccountUsecase(repository: makeAccountRepository())
    }
    
    func makeQuestUsecase() -> QuestUsecase {
        return DefaultQuestUsecase(repository: makeQuestRepository())
    }
    
    func makeRnakingUsecase() -> RankingUsecase {
        return DefaultRankingUsecase(repository: makeRankingRepository())
    }
    
    func makeProfileUsecase() -> ProfileUsecase {
        return DefaultProfileUsecase(repository: makeProfileRepository())
    }
    
    private func makeAccountRepository() -> AccountRepository {
        return DefaultAccountRepository(networkService: networkSevice)
    }
    
    private func makeQuestRepository() -> QuestRepository {
        return DefaultQuestRepository(networkService: networkSevice)
    }
    
    private func makeRankingRepository() -> RankingRepository {
        return DefaultRankingRepository(networkService: networkSevice)
    }
    
    private func makeProfileRepository() -> ProfileRepository {
        return DefaultProfileRepository(networkService: networkSevice)
    }
}
