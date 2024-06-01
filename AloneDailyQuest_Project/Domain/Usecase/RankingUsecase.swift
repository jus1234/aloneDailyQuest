//
//  RankingUsecase.swift
//  AloneDailyQuest_Project
//
//  Created by Wooseok on 5/8/24.
//

import Foundation
import RxSwift

protocol RankingUsecase {
    typealias Observable = RxSwift.Observable
    
    func fetch() -> Observable<[UserInfo]>
    func fetchUserRanking(nickName: String) -> Observable<Int>
}

final class DefaultRankingUsecase: RankingUsecase {
    typealias Observable = RxSwift.Observable
    
    private let repository: RankingRepository
    
    init(repository: RankingRepository) {
        self.repository = repository
    }
    
    func fetch() -> Observable<[UserInfo]> {
        return repository.fetchRanking()
    }
    
    func fetchUserRanking(nickName: String) -> Observable<Int> {
        return repository.fetchUserRanking(nickName: nickName)
    }
}
