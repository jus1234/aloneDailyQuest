//
//  AccountRepository.swift
//  AloneDailyQuest_Project
//
//  Created by Wooseok on 5/7/24.
//

import Foundation
import RxSwift

final class DefaultRankingRepository: RankingRepository {
    private let networkService: NetworkService
    private let decorder: JSONDecoder = JSONDecoder()
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func fetchRanking() -> Single<[UserInfo]> {
        return networkService
            .request(.ranking)
            .flatMap { [weak self] data -> Single<[UserInfo]> in
                do {
                    guard let rankList = try self?.decorder.decode([UserInfoDTO].self, from: data) 
                    else {
                        throw NetworkError.dataError
                    }
                    return Single.just(rankList.map { $0.toEntity() })
                } catch {
                    return Single.error(error)
                }
            }
    }
    
    func fetchUserRanking(nickName: String) -> Single<Int> {
        return networkService
            .request(.myRanking(userId: UserIdRequestDTO(userId: nickName)))
            .flatMap { [weak self] data in
                do {
                    guard let myRank = try self?.decorder.decode(MyRankingResponseDTO.self, from: data).rank 
                    else {
                        throw NetworkError.dataError
                    }
                    return Single.just(myRank)
                } catch {
                    return Single.error(NetworkError.dataError)
                }
            }
    }
}
