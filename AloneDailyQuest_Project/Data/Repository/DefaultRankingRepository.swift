//
//  AccountRepository.swift
//  AloneDailyQuest_Project
//
//  Created by Wooseok on 5/7/24.
//

import Foundation
import RxSwift

final class DefaultRankingRepository: RankingRepository {
    typealias Observable = RxSwift.Observable
    
    private let networkService: NetworkService
    private let decorder: JSONDecoder = JSONDecoder()
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func fetchRanking() -> Observable<[UserInfo]> {
        return networkService.requestObservable(.ranking)
            .flatMap { data -> Observable<[UserInfo]> in
                do {
                    let rankList = try self.decorder.decode([UserInfoDTO].self, from: data).map { $0.toEntity() }
                    return Observable.just(rankList)
                } catch {
                    return Observable.error(NetworkError.dataError)
                }
            }
    }
    
    func fetchUserRanking(nickName: String) -> Observable<Int> {
        return networkService.requestObservable(.myRanking(userId: UserIdRequestDTO(userId: nickName)))
            .flatMap { data in
                do {
                    let myRank = try self.decorder.decode(MyRankingResponseDTO.self, from: data).rank
                    return Observable.just(myRank)
                } catch {
                    return Observable.error(NetworkError.dataError)
                }
            }
    }
}
