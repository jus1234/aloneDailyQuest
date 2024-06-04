//
//  RankingRepository.swift
//  AloneDailyQuest_Project
//
//  Created by Wooseok on 5/7/24.
//

import Foundation
import RxSwift

protocol RankingRepository {
    func fetchRanking() -> Single<[UserInfo]>
    func fetchUserRanking(nickName: String) -> Single<Int>
}
