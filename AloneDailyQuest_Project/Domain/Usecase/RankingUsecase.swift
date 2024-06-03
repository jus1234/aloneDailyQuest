//
//  RankingUsecase.swift
//  AloneDailyQuest_Project
//
//  Created by Wooseok on 5/8/24.
//

import Foundation
import RxSwift

protocol RankingUsecase {
    func fetchRankingList() -> Single<[UserInfo]>
    func fetchUserRanking(nickName: String) -> Single<Int>
}

final class DefaultRankingUsecase: RankingUsecase {
    private let repository: RankingRepository
    
    init(repository: RankingRepository) {
        self.repository = repository
    }
    
    func fetchRankingList() -> Single<[UserInfo]> {
        return repository.fetchRanking()
    }
    
    func fetchUserRanking(nickName: String) -> Single<Int> {
        return repository.fetchUserRanking(nickName: nickName)
    }
}
