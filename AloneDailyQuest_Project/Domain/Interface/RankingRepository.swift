//
//  RankingRepository.swift
//  AloneDailyQuest_Project
//
//  Created by Wooseok on 5/7/24.
//

import Foundation
import RxSwift

protocol RankingRepository {
    typealias Observable = RxSwift.Observable
    
    func fetchRanking() -> Observable<[UserInfo]>
    func fetchUserRanking(nickName: String) -> Observable<Int>
}
