//
//  AccountRepository.swift
//  AloneDailyQuest_Project
//
//  Created by Wooseok on 5/7/24.
//

import Foundation
import RxSwift

protocol AccountRepository {
    func signup(userId: String) -> Completable
    func checkId(userId: String) -> Single<Bool>
    func fetchUserInfo(userId: String) -> Single<UserInfo>
    func fetchExperience(userId: String) -> Single<Int>
    func addExperience(user: UserInfo) -> Single<Int>
}
